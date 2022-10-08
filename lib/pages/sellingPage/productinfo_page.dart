import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:upwork_app/pages/sellingPage/createorder_page.dart';

import '../../main.dart';
import '../../models/create_order.dart';
import '../../models/user.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/title_widget.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key, this.finalConfirmation}) : super(key: key);
  final bool? finalConfirmation;
  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int timer = 10;
  Timer? x;

  List<Widget> setUp() {
    final chosenProduct = Provider.of<CreateOrder>(context, listen: true);
    List<Widget> childList = [];
    List<Widget> parentList = [];
    List<Widget> accList = [];
    List<Widget> warList = [];
    chosenProduct.deviceReport ??= [];
    chosenProduct.warrantyInStorage ??= [];
    chosenProduct.accessories ??= [];

    for (var element in chosenProduct.accessories!) {
      accList.add(childText(element.name));
    }

    for (var element in chosenProduct.warrantyInStorage!) {
      warList.add(childText(element.name));
    }

    for (var element in chosenProduct.deviceReport!) {
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

  @override
  void initState() {
    super.initState();
    if (widget.finalConfirmation != null && widget.finalConfirmation!) {
      x = Timer.periodic(const Duration(seconds: 1), (t) {
        setState(() {
          timer -= 1;
        });
      });
    }
  }

  @override
  void dispose() {
    if (x != null) x!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chosenProduct = Provider.of<CreateOrder>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.finalConfirmation ?? false,
        title: const Text("Product info"),
      ),
      body: Column(
        children: [
          if (widget.finalConfirmation != null && widget.finalConfirmation!)
            Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              child: Text(
                "Please confirm that everything is correct before you place the order",
                style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          Flexible(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            const SizedBox(height: 10),
                            const ShortCutTitle(title: "Chosen device:"),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        chosenProduct.chosenProduct!.image,
                                    height: 250.sp,
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          chosenProduct.chosenProduct!.name,
                                          style: TextStyle(
                                              fontSize: 50.sp,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.7),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "Selected variant: ${chosenProduct.getChosenVariant().variant}",
                                          style: TextStyle(
                                              fontSize: 50.sp,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            (setUp().isEmpty)
                                ? Container()
                                : const ShortCutTitle(
                                    title: "Device evaluation:"),
                            ...setUp(),
                            if (widget.finalConfirmation != null &&
                                widget.finalConfirmation!)
                              const SizedBox(height: 20),
                            const Spacer(),
                            if (widget.finalConfirmation != null &&
                                widget.finalConfirmation!)
                              Button(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => wrapper()),
                                      (route) => route.isFirst);
                                },
                                enabled: (timer < 1),
                                child: AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    child: (timer < 1)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "CONFIRM",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 50.sp),
                                              ),
                                            ],
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: Text(
                                              timer.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 50.sp),
                                            ),
                                          )),
                              )
                          ]),
                        ),
                      ]))),
        ],
      ),
    );
  }

  Widget wrapper() {
    return Consumer<UserModel>(builder: (context, value, child) {
      if (value.email != null && value.email != "invalid@email.com") {
        return const CalculateOrder();
      } else {
        return const AuthStructure();
      }
    });
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
}
