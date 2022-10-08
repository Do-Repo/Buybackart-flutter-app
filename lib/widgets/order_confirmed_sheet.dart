import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'button_widget.dart';

class OrderConfirmed extends StatelessWidget {
  const OrderConfirmed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:
            CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Text(
                  "Your Order Have been Placed Successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 60.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.7),
                ),
                const SizedBox(height: 10),
                Text(
                  "Thanks For choosing buybackart, We will get back to you very soon",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.7),
                ),
                SizedBox(height: 10),
                Text(
                  "Someone from our team will reach out to you. Please check your email for the order details. Please keep a photocopy of your id proof ready when our executive will pick your device.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor,
                      letterSpacing: -0.7),
                ),
                Spacer(),
                Button(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue",
                          style: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
