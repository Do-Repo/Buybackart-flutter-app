// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:upwork_app/controllers/post_login.dart';
import 'package:upwork_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.homeTabController, this.authTabController})
      : super(key: key);
  final TabController? homeTabController, authTabController;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String errorHint = '';

  TextEditingController phoneController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  void signIn(String phone, pin) {
    context.loaderOverlay.show();
    var currentUser = Provider.of<UserModel>(context, listen: false);
    Future<UserModel?> future = login(phone, pin);
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
    if (text.length == 1) {
      FocusScope.of(context).nextFocus();
    } else {
      FocusScope.of(context).previousFocus();
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong, try again later")));
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
                          return null;
                        },
                      ),
                      Text(
                        " Enter your 6 digit pin:",
                        style: TextStyle(
                            fontSize: 50.sp,
                            color: Colors.black.withOpacity(0.5)),
                      ),
                      PinCodeTextField(
                        controller: pinController,
                        appContext: context,
                        length: 6,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {},
                        enablePinAutofill: false,
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
                                  if (!_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Some required fields are still empty')));
                                  } else {
                                    signIn(phoneController.text,
                                        pinController.text);
                                  }
                                },
                                child: Text(
                                  "SIGN IN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 50.sp),
                                )),
                            Button(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  widget.authTabController!.animateTo(1);
                                },
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 50.sp),
                                )),
                            Button(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  widget.authTabController!.animateTo(2);
                                },
                                child: Text(
                                  "LOGIN WITH OTP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 50.sp),
                                ))
                          ],
                        ),
                      ),
                      if (widget.homeTabController != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Row(
                            children: [
                              Flexible(
                                  child: Divider(
                                thickness: 1,
                                color: Theme.of(context).primaryColor,
                              )),
                              Text(
                                "  OR  ",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Flexible(
                                  child: Divider(
                                thickness: 1,
                                color: Theme.of(context).primaryColor,
                              )),
                            ],
                          ),
                        ),
                      if (widget.homeTabController != null)
                        tabs(context, "Services", "assets/icons/smartphone.png",
                            () {
                          widget.homeTabController!.animateTo(2);
                        }),
                      if (widget.homeTabController != null)
                        tabs(context, "Contact Us", "assets/icons/support.png",
                            () => _launchUrl(contacturl)),
                      if (widget.homeTabController != null)
                        tabs(
                            context,
                            "Privacy Policy",
                            "assets/icons/insurance.png",
                            () => _launchUrl(privacyurl)),
                      if (widget.homeTabController != null)
                        tabs(
                            context,
                            "Terms & Conditions",
                            "assets/icons/contract.png",
                            () => _launchUrl(termsconditionsurl))
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

Widget tabs(BuildContext context, String text, image, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(image, height: 80.sp),
          const SizedBox(width: 20),
          Text(text,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 50.sp,
                  fontWeight: FontWeight.w600)),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    ),
  );
}
