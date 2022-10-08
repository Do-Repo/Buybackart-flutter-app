import 'package:upwork_app/controllers/post_additionalinfo.dart';
import 'package:upwork_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/button_widget.dart';

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({Key? key}) : super(key: key);
  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  final _formKey = GlobalKey<FormState>();
  String errorHint = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void updateInfo(String phone, email, name) {
    var currentUser = Provider.of<UserModel>(context, listen: false);
    context.loaderOverlay.show();
    Future<UserModel?> future =
        additionalInfo(phone, email, name, currentUser.token);
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
    var currentUser = Provider.of<UserModel>(context, listen: false);
    return Scaffold(
      body: LoaderOverlay(
        child: CustomScrollView(slivers: [
          const CustomAppbar(title: "More info"),
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
                      " We need some more info before you can login:",
                      style: TextStyle(
                          fontSize: 50.sp,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                    const SizedBox(height: 20),
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
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Row(
                        children: [
                          SizedBox(width: 800.w),
                          Button(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                if (!_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Some required fields are still empty')));
                                } else {
                                  updateInfo(
                                      currentUser.phone_number!,
                                      emailController.text,
                                      nameController.text);
                                }
                              },
                              child: Text(
                                "CONTINUE",
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
        ]),
      ),
    );
  }
}
