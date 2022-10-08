// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:upwork_app/controllers/post_register.dart';
import 'package:upwork_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/button_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key, required this.authTabController})
      : super(key: key);
  final TabController authTabController;
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String errorHint = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  void signUp(String name, phone, email, pin) async {
    context.loaderOverlay.show();
    var currentUser = Provider.of<UserModel>(context, listen: false);
    Future<UserModel?> future = register(name, email, phone, pin);
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
            const CustomAppbar(title: 'Sign up'),
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
                        controller: nameController,
                        decoration: InputDecoration(
                            border: textfieldBorder(context),
                            enabledBorder: textfieldBorder(context),
                            label: const Text("Full name")),
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny("[0-9]")
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: phoneController,
                        decoration: InputDecoration(
                          border: textfieldBorder(context),
                          enabledBorder: textfieldBorder(context),
                          label: const Text("Phone number"),
                          prefix: const Text(' +91 '),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            border: textfieldBorder(context),
                            enabledBorder: textfieldBorder(context),
                            label: const Text("Email address")),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field required";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
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
                                  widget.authTabController.animateTo(0);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                )),
                            SizedBox(width: 600.w),
                            Button(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Some required fields are still empty')),
                                    );
                                  } else {
                                    signUp(
                                        nameController.text,
                                        phoneController.text,
                                        emailController.text,
                                        pinController.text);
                                  }
                                },
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 50.sp),
                                )),
                          ],
                        ),
                      )
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
