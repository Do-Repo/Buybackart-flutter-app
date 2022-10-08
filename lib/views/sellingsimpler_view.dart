import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/stepper_widget.dart' as step;

class SellingSimpler extends StatefulWidget {
  const SellingSimpler({Key? key}) : super(key: key);

  @override
  State<SellingSimpler> createState() => _SellingSimplerState();
}

class _SellingSimplerState extends State<SellingSimpler> {
  int currentStep = 0;
  List<Image> images = [
    Image.asset('assets/images/evaluate.png', height: 600.h),
    Image.asset('assets/images/schedule.png', height: 600.h),
    Image.asset('assets/images/payment.png', height: 600.h)
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        // color: Theme.of(context).primaryColor.withOpacity(0.1),
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.5,
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: images[currentStep]),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "We Made Selling Simpler",
                    style: TextStyle(
                        letterSpacing: -0.7,
                        wordSpacing: 1,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                ),
                step.MyStepper(
                    controlsBuilder: (context, details) => Container(),
                    currentStep: currentStep,
                    onStepTapped: (index) {
                      setState(() => currentStep = index);
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    steps: [
                      step.Step(
                          state: (currentStep == 0)
                              ? step.StepState.complete
                              : step.StepState.indexed,
                          title: Text("Evaluate Price",
                              style: TextStyle(
                                  letterSpacing: -0.7,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: (currentStep == 0)
                                      ? Theme.of(context).primaryColor
                                      : null)),
                          content: Text(
                            "Choose your device and tell us about its present condition and our advanced AI technology will find the correct price for you.",
                            style: TextStyle(
                                fontSize: 50.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.7),
                          )),
                      step.Step(
                          state: (currentStep == 1)
                              ? step.StepState.complete
                              : step.StepState.indexed,
                          title: Text("Schedule Pickup",
                              style: TextStyle(
                                  letterSpacing: -0.7,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: (currentStep == 1)
                                      ? Theme.of(context).primaryColor
                                      : null)),
                          content: Text(
                            "Book free pickup on a slot that matches convenience at home or work place.",
                            style: TextStyle(
                                fontSize: 50.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.7),
                          )),
                      step.Step(
                          state: (currentStep == 2)
                              ? step.StepState.complete
                              : step.StepState.indexed,
                          title: Text("Instant Payment",
                              style: TextStyle(
                                  letterSpacing: -0.7,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: (currentStep == 2)
                                      ? Theme.of(context).primaryColor
                                      : null)),
                          content: Text(
                            "Have we stated that once our executive picks up your device you Get paid? Payment is immediate all the way!",
                            style: TextStyle(
                                fontSize: 50.sp,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.7),
                          ))
                    ]),
              ],
            ),
          ],
        ));
  }
}
