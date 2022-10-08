import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';
import '../widgets/appbar_widget.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomAppbar(title: 'Contact us'),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    "Feel Free to contact us any time. We will get back to you as soon as we can!.",
                    style: TextStyle(
                        fontSize: 50.sp, color: Colors.black.withOpacity(0.5)),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Full name",
                        border: textfieldBorder(context),
                        enabledBorder: textfieldBorder(context)),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Email address",
                        border: textfieldBorder(context),
                        enabledBorder: textfieldBorder(context)),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                        hintText: "Write your message",
                        label: const Text("Message"),
                        border: textfieldBorder(context),
                        enabledBorder: textfieldBorder(context)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
