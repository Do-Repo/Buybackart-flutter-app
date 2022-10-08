import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import 'button_widget.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen(
      {Key? key,
      required this.index,
      required this.tabController,
      required this.image,
      required this.title,
      required this.firstSubtitle,
      required this.secondSubtitle,
      required this.thirdSubtitle})
      : super(key: key);
  final int index;
  final TabController tabController;
  final String image, title, firstSubtitle, secondSubtitle, thirdSubtitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title,
                style: TextStyle(
                    fontSize: 90.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                  size: 80.sp,
                ),
                const SizedBox(width: 10),
                Text(firstSubtitle,
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                  size: 80.sp,
                ),
                const SizedBox(width: 10),
                Text(secondSubtitle,
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                  size: 80.sp,
                ),
                const SizedBox(width: 10),
                Text(thirdSubtitle,
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor)),
              ],
            ),
          ),
          const Spacer(),
          Image.asset(
            image,
            fit: BoxFit.fitHeight,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              children: [
                (index != 0)
                    ? GestureDetector(
                        onTap: () {
                          tabController.animateTo(index - 1);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).primaryColor,
                          size: 100.sp,
                        ),
                      )
                    : Container(),
                const Spacer(),
                (index != tabController.length - 1)
                    ? GestureDetector(
                        onTap: () {
                          tabController.animateTo(index + 1);
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).primaryColor,
                          size: 100.sp,
                        ),
                      )
                    : Button(
                        color: Theme.of(context).primaryColor.withOpacity(0.9),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Structure()));
                        },
                        child: Text(
                          "      Get Started      ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 50.sp,
                          ),
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
