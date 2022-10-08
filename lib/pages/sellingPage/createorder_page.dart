import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:upwork_app/controllers/get_questions.dart';
import 'package:upwork_app/controllers/post_create_order.dart';
import 'package:upwork_app/models/create_order.dart';
import 'package:upwork_app/models/order.dart';
import 'package:upwork_app/models/user.dart';
import 'package:upwork_app/pages/errorpage.dart';
import 'package:upwork_app/pages/sellingPage/shipping_page.dart';
import 'package:upwork_app/widgets/button_widget.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class CalculateOrder extends StatefulWidget {
  const CalculateOrder({Key? key}) : super(key: key);

  @override
  State<CalculateOrder> createState() => _CalculateOrderState();
}

class _CalculateOrderState extends State<CalculateOrder> {
  bool isChecked = false;
  late Future<CreateOrder> future;
  late Order? orderlog;

  @override
  void initState() {
    super.initState();
    future = setUp();
  }

  Future<CreateOrder> setUp() async {
    var order = Provider.of<CreateOrder>(context, listen: false);
    var user = Provider.of<UserModel>(context, listen: false);

    var total = order.getChosenVariant().market_retail_price.toDouble();
    var reasonlist = [];
    var allQuestions = await getQuestions(order.chosenOption!.id);

    for (var element in order.deviceReport!) {
      // Make temporary list store in questions with answers
      reasonlist.add(element.parentId);

      // Weightage is acting like percentage
      // If question has NO child (subQuestions) it's a yes or no question
      // and has only 1 weightage, else it sums up the weightage of each subQuestion
      if (element.child.isEmpty) {
        total = total - (total * (element.weightage) / 100);
      } else {
        var sum = 0;
        for (var child in element.child) {
          sum += child.weightage;
        }
        total = total - (total * (sum) / 100);
      }
    }
    order.accessories ??= [];
    // Unlike the questions, for accessories and warranties
    // we calculate percentage of market retail price and not total price
    // For accessories the more the better so we add percentage instead of reducing
    for (var element in order.accessories!) {
      total = total +
          (order.getChosenVariant().market_retail_price *
              ((element.weightage) / 100));
    }

    for (var element in order.warrantyInStorage!) {
      total = total -
          (order.getChosenVariant().market_retail_price *
              ((element.weightage) / 100));
    }

    // Remove all questions that are already answered
    allQuestions.retainWhere((item) => !reasonlist.contains(item.id));

    // Add all unanswered questions, this is because for some reason
    // unanswered questions are also passed to the api. I don't know why
    // I didn't do the backend lol
    for (var element in allQuestions) {
      order.addQuestion(element, null, null);
    }

    var st = CreateOrder(
      id: order.chosenProduct!.id,
      varId: order.getVarId(),
      accessories: order.accessories ?? [],
      calculation: total.toInt(),
      total: total.toInt(),
      deviceReport: order.deviceReport ?? [],
      warrantyInStorage: order.warrantyInStorage ?? [],
    );

    orderlog = await createOrder(st.toJson(), user.token);
    return st;
  }

  int selectionCount(CreateOrder order) {
    // Count how many issues the user has chosen
    // 5 or more issues makes the phone worthless
    int count = 0;
    if (order.deviceReport != null) {
      for (int i = 0; i < order.deviceReport!.length; i++) {
        count += order.deviceReport![i].child.length;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<CreateOrder>(context);
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
            future: future,
            builder: ((context, AsyncSnapshot<CreateOrder> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return loading();
              } else if (snapshot.hasError) {
                return ErrorScreen(
                    snapshot: snapshot,
                    onPressed: () {
                      setState(() {
                        future = setUp();
                      });
                    });
              } else {
                if (selectionCount(order) > 4 ||
                    snapshot.data!.total!.isNegative) {
                  return manyIsues(order, context);
                } else {
                  return IsConfirmed(
                      order: order,
                      orderlog: orderlog!,
                      snapshot: snapshot.data!);
                }
              }
            })));
  }

  Column manyIsues(CreateOrder order, BuildContext context) {
    return Column(
      children: [
        appInfo(order, context),
        Padding(
            padding: const EdgeInsets.all(10),
            child: RichText(
              text: TextSpan(
                  text:
                      "Your device contains many issues, to get the best price please contact our customer care service: ",
                  style: TextStyle(fontSize: 50.sp, color: Colors.black),
                  children: [
                    TextSpan(
                        text: "+91 9310353308",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => url_launcher
                              .launchUrl(Uri.parse("tel:+919310353308")),
                        style: TextStyle(
                            fontSize: 50.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold))
                  ]),
            )),
        const Spacer(),
        Button(
            color: Theme.of(context).primaryColor,
            onPressed: () => Navigator.of(context).pop(),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Continue",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.bold),
              )
            ]))
      ],
    );
  }

  Column loading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(
          width: double.infinity,
          height: 20,
        ),
        Text(
          "Calculating...",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.sp),
        )
      ],
    );
  }
}

Column appInfo(CreateOrder order, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(
        height: 20,
        width: double.infinity,
      ),
      CachedNetworkImage(
        imageUrl: order.chosenProduct!.image,
        height: 200,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
          order.chosenProduct!.name,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 60.sp,
              letterSpacing: -0.7),
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
              child: Container(
            height: 2,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Theme.of(context).primaryColor,
          )),
          Text(
            order.chosenProduct!.variants
                .firstWhere((element) => element.id == order.varId)
                .variant,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 50.sp),
          ),
          Flexible(
              child: Container(
            height: 2,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Theme.of(context).primaryColor,
          )),
        ],
      ),
    ],
  );
}

class IsConfirmed extends StatefulWidget {
  const IsConfirmed(
      {Key? key,
      required this.order,
      required this.snapshot,
      required this.orderlog})
      : super(key: key);
  final CreateOrder order;
  final CreateOrder snapshot;
  final Order orderlog;

  @override
  State<IsConfirmed> createState() => _IsConfirmedState();
}

class _IsConfirmedState extends State<IsConfirmed> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appInfo(widget.order, context),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: RichText(
                text: TextSpan(
                    text: "Selling Price: ",
                    style: TextStyle(
                        fontSize: 54.sp,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: "₹${widget.snapshot.total.toString()}",
                          style: TextStyle(
                              fontSize: 60.sp, fontWeight: FontWeight.bold))
                    ]),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                    text: "Disclaimer: ",
                    style: TextStyle(
                        fontSize: 54.sp,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text:
                              "Please note this amount is subject to change upon pysical device inspection",
                          style: TextStyle(
                              fontSize: 50.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.normal))
                    ]),
              )),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 7,
                      color: Colors.grey.withOpacity(0.4))
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                        child: Container(
                      height: 1,
                      width: double.infinity,
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.black,
                    )),
                    Text(
                      "Contract",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 50.sp),
                    ),
                    Flexible(
                        child: Container(
                      height: 1,
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 10),
                      color: Colors.black,
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Evaluated Price:",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        "₹${widget.snapshot.total.toString()}",
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  child: Row(
                    children: const [
                      Text(
                        "Pickup Charges:",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        "- ₹0.00",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
                  child: Row(
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 50.sp),
                      ),
                      const Spacer(),
                      Text(
                        "₹${widget.snapshot.total.toString()}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 50.sp),
                      )
                    ],
                  ),
                ),
                const Divider(),
                CheckboxListTile(
                    value: isChecked,
                    onChanged: (val) => setState(() {
                          isChecked = !isChecked;
                        }),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Theme.of(context).primaryColor,
                    title: RichText(
                      text: TextSpan(
                          text: "I agree to the ",
                          style:
                              TextStyle(fontSize: 50.sp, color: Colors.black),
                          children: [
                            TextSpan(
                                text: "terms and conditions",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => url_launcher.launchUrl(Uri.parse(
                                      "https://www.buybackart.com/#/terms-and-conditions")),
                                style: TextStyle(
                                    fontSize: 50.sp,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold))
                          ]),
                    )),
                Button(
                    color: Theme.of(context).primaryColor,
                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                ShippingInfo(orderid: widget.orderlog.id))),
                    enabled: isChecked,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
