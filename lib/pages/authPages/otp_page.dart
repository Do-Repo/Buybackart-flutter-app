// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:upwork_app/controllers/post_otp.dart';
import 'package:upwork_app/models/user.dart';
import 'package:upwork_app/services/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/button_widget.dart';

class SignInOTP extends StatefulWidget {
  const SignInOTP({Key? key, required this.authTabController})
      : super(key: key);
  final TabController authTabController;
  @override
  State<SignInOTP> createState() => _SignInOTPState();
}

class _SignInOTPState extends State<SignInOTP> {
  bool hasSent = false;
  final _formKey = GlobalKey<FormState>();
  String errorHint = '';

  TextEditingController phoneController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  void requestcode(String phone) {
    context.loaderOverlay.show();
    Future<bool?> future = requestOTP(phone);
    future.then((value) {
      if (value != null && value == true) {
        context.loaderOverlay.hide();
        setState(() {
          hasSent = true;
          errorHint = "";
        });
      }
    }).catchError((e) {
      setState(() {
        context.loaderOverlay.hide();
        errorHint = e.toString();
      });
    });
  }

  void verifycode(String phone, code) {
    context.loaderOverlay.show();
    var currentUser = Provider.of<UserModel>(context, listen: false);
    Future<UserModel?> future = verifyOTP(phone, code);
    future.then((value) async {
      if (value != null) {
        currentUser.setUser(value);
        context.loaderOverlay.hide();
      }
    }).catchError((e) {
      setState(() {
        context.loaderOverlay.hide();
        errorHint = e.toString();
      });
    });
  }

  void focusHopping(String text) {
    if (text.isNotEmpty) {
      FocusScope.of(context).nextFocus();
    } else {
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  void initState() {
    super.initState();
    if (context.loaderOverlay.visible) {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
        child: CustomScrollView(
          slivers: [
            const CustomAppbar(title: 'Sign in'),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      AnimatedCrossFade(
                          firstChild: Container(),
                          secondChild: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text(
                              errorHint,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          crossFadeState: errorHint.isEmpty
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 300)),
                      Text(
                        " Sign in with OTP:",
                        style: TextStyle(
                            fontSize: 50.sp,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: textfieldBorder(context),
                          enabledBorder: textfieldBorder(context),
                          label: const Text("Phone number"),
                          prefix: const Text(' +91 '),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field required";
                          }
                        },
                      ),
                      AnimatedCrossFade(
                          firstChild: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Row(
                              children: [
                                Button(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      widget.authTabController.animateTo(0);
                                    },
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )),
                                SizedBox(width: 400.w),
                                Button(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      requestcode(phoneController.text);
                                    },
                                    child: Text(
                                      "REQUEST AN OTP",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 50.sp),
                                    ))
                              ],
                            ),
                          ),
                          secondChild: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PinCodeTextField(
                                controller: pinController,
                                appContext: context,
                                length: 6,
                                obscureText: false,
                                onChanged: (val) {},
                                keyboardType: TextInputType.number,
                                enablePinAutofill: true,
                                pinTheme: PinTheme(
                                  inactiveColor: Colors.grey,
                                  activeColor: Theme.of(context).primaryColor,
                                  selectedColor: Theme.of(context).primaryColor,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  children: [
                                    Button(
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          widget.authTabController.animateTo(0);
                                        },
                                        child: const Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        )),
                                    Button(
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          requestcode(phoneController.text);
                                        },
                                        child: Text(
                                          "RESEND OTP",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 50.sp),
                                        )),
                                    Button(
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Some required fields are still empty')));
                                          } else {
                                            verifycode(phoneController.text,
                                                pinController.text);
                                          }
                                        },
                                        child: Text(
                                          "SIGN IN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 50.sp),
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          crossFadeState: (hasSent)
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          sizeCurve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 300))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
