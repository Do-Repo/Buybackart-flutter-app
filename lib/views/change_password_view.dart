import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../controllers/patch_edit_password.dart';
import '../models/user.dart';
import '../widgets/button_widget.dart';
import '../widgets/title_widget.dart';

class ChangePin extends StatefulWidget {
  const ChangePin({Key? key}) : super(key: key);

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends State<ChangePin> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController pinController = TextEditingController();

  void focusHopping(String text) {
    if (text.length == 1) {
      FocusScope.of(context).nextFocus();
    } else {
      FocusScope.of(context).previousFocus();
    }
  }

  void editPin() async {
    final user = Provider.of<UserModel>(context, listen: false);
    context.loaderOverlay.show();
    await editPassword(pinController.text, user.phone_number, user.token)
        .then((value) {
      context.loaderOverlay.hide();
      if (value != null && value.token!.isNotEmpty) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Pin edited successfully")));
      }
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Change Pin')),
        body: LoaderOverlay(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ShortCutTitle(title: "Change your login pin"),
                        const Text("Enter Your New 6 Digit Pin"),
                        PinCodeTextField(
                          controller: pinController,
                          appContext: context,
                          length: 6,
                          obscureText: true,
                          onChanged: (val) {},
                          keyboardType: TextInputType.number,
                          enablePinAutofill: false,
                          pinTheme: PinTheme(
                            inactiveColor: Colors.grey,
                            activeColor: Theme.of(context).primaryColor,
                            selectedColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        const Spacer(),
                        Button(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                editPin();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Continue",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 50.sp),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
