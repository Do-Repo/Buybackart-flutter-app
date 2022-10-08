import 'package:auto_size_text/auto_size_text.dart';
import 'package:upwork_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key, required this.snapshot, required this.onPressed})
      : super(key: key);
  final AsyncSnapshot snapshot;
  final VoidCallback onPressed;
  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/No data.gif"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: AutoSizeText(
              widget.snapshot.error.toString(),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 50.sp),
            ),
          ),
          Button(
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              onPressed: widget.onPressed,
              child: const Text(
                "Try again",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ))
        ],
      ),
    );
  }
}
