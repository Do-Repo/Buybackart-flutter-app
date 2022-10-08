// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:upwork_app/controllers/get_orders.dart';
import 'package:upwork_app/controllers/get_product_details.dart';
import 'package:upwork_app/models/order.dart';
import 'package:upwork_app/pages/errorpage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/create_order.dart';
import '../models/user.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key, required this.orderId}) : super(key: key);
  final String orderId;
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late Future<List<dynamic>> future;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserModel>(context, listen: false);
    future = Future.wait([
      getOrder(user.token.toString(), widget.orderId),
      getProductSum(widget.orderId, user.token.toString())
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context, listen: false);
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
              appBar: AppBar(title: Text("Order details | ${widget.orderId}")),
              body: const Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Order details | ${widget.orderId}")),
            body: ErrorScreen(
                snapshot: snapshot,
                onPressed: () {
                  setState(() {
                    future = Future.wait([
                      getOrder(user.token.toString(), widget.orderId),
                      getProductSum(widget.orderId, user.token.toString())
                    ]);
                  });
                }),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text("Order details | ${widget.orderId}"),
              actions: [
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => PInfo(
                              orderInfo: snapshot.data![0],
                              productInfo: snapshot.data![1]));
                    },
                    icon: Icon(Icons.phone_android_outlined))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    RichText(
                        text: TextSpan(
                            text: "Created By: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: snapshot.data![0].user,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "User Email: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: snapshot.data![0].email,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "Phone Number: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: snapshot.data![0].phone_number,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "Assigned To: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: (snapshot.data![0].assigned_to.isEmpty)
                                  ? "Not Assigned to Any Staff"
                                  : snapshot.data![0].assigned_to,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "Assigned Executive Number: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: (snapshot.data![0].assigned_executive_number
                                          .toString() ==
                                      "0")
                                  ? "Not Available"
                                  : snapshot.data![0].assigned_executive_number
                                      .toString(),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "Used Refferal Code: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text:
                                  (snapshot.data![0].used_refferal_code.isEmpty)
                                      ? "Did not use any refferal code"
                                      : snapshot.data![0].used_refferal_code,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "Pickup Address: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: (snapshot.data![0].pick_up_location.isEmpty)
                                  ? "Pickup location was not updated"
                                  : snapshot.data![0].pick_up_location,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "City: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: (snapshot.data![0].city.isEmpty)
                                  ? "Not Updated"
                                  : snapshot.data![0].city,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "State: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: (snapshot.data![0].state.isEmpty)
                                  ? "Not Updated"
                                  : snapshot.data![0].state,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "Status: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: snapshot.data![0].status,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "Scheduled Date: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: (snapshot.data![0].schedualed_date.isEmpty)
                                  ? "Not Updated"
                                  : snapshot.data![0].schedualed_date,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "Time Slot: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: (snapshot.data![0].time_slot.isEmpty)
                                  ? "Not Updated"
                                  : snapshot.data![0].time_slot,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "Preffered Payment Option: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: (snapshot.data![0].preffered_payment_option
                                      .isEmpty)
                                  ? "Not Updated"
                                  : snapshot.data![0].preffered_payment_option,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "Created At: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: DateFormat("yyyy-MM-dd | HH:mm:ss ")
                                  .format(DateTime.parse(
                                      snapshot.data![0].timestamp))
                                  .toString(),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                    RichText(
                        text: TextSpan(
                            text: "Updated At: ",
                            style:
                                TextStyle(fontSize: 45.sp, color: Colors.black),
                            children: [
                          TextSpan(
                              text: DateFormat("yyyy-MM-dd | HH:mm:ss ")
                                  .format(
                                      DateTime.parse(snapshot.data![0].updated))
                                  .toString(),
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    Divider(),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class PInfo extends StatelessWidget {
  const PInfo({Key? key, required this.orderInfo, required this.productInfo})
      : super(key: key);
  final FinalizedOrder orderInfo;
  final ProductSum productInfo;

  List<Widget> setUp() {
    List<Widget> childList = [];
    List<Widget> parentList = [];
    List<Widget> accList = [];
    List<Widget> warList = [];

    for (var element in productInfo.accessories) {
      accList.add(childText(element.name));
    }

    warList.add(childText(orderInfo.warranty));

    for (var element in productInfo.report) {
      childList.clear();
      if (element.child.isNotEmpty) {
        for (var element in element.child) {
          childList.add(childText(element.sub_question));
        }
      }

      parentList.add(container(
        [parentText(element.question), ...childList],
      ));
    }

    if (accList.isNotEmpty) {
      parentList
          .add(container([parentText("Attached Accessories"), ...accList]));
    }

    if (warList.isNotEmpty) {
      parentList.add(container([parentText("Device Warranty"), ...warList]));
    }

    return parentList;
  }

  Container container(List<Widget> children) {
    return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 5,
              color: Colors.grey.withOpacity(0.5))
        ]),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: children));
  }

  Text parentText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 45.sp, fontWeight: FontWeight.w600, letterSpacing: -0.7),
    );
  }

  Padding childText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: RichText(
          text: TextSpan(
              text: "• ",
              style: TextStyle(
                  fontSize: 60.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: [
            TextSpan(
                text: text,
                style: TextStyle(
                  fontSize: 40.sp,
                  letterSpacing: -0.7,
                  fontWeight: FontWeight.normal,
                ))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Info"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSize(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: CachedNetworkImage(
                        imageUrl: orderInfo.prod_image,
                        height: 100,
                        progressIndicatorBuilder: (context, url, progress) {
                          return Container(
                            width: 100,
                            height: 100,
                            padding: EdgeInsets.all(30),
                            child: CircularProgressIndicator(
                                value: progress.progress),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderInfo.product,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50.sp,
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            "Selected variant: ${orderInfo.variant}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 45.sp,
                                color: Theme.of(context).primaryColor),
                          ),
                          if (!orderInfo.auto_evaluated_price.isNegative)
                            SizedBox(height: 10),
                          (orderInfo.auto_evaluated_price.isNegative)
                              ? RichText(
                                  text: TextSpan(
                                      text:
                                          "Your device contains many issues, to get the best price please contact our customer care service: ",
                                      style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                            text: "+91 9310353308",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => launchUrl(
                                                  Uri.parse(
                                                      "tel:+919310353308")),
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                )
                              : RichText(
                                  text: TextSpan(
                                      text: "Selling Price: ",
                                      style: TextStyle(
                                          fontSize: 54.sp,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                            text: "₹${orderInfo.final_price}",
                                            style: TextStyle(
                                                fontSize: 60.sp,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Column(
                children: setUp(),
              )
            ],
          )),
    );
  }
}
