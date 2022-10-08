import 'package:flutter/material.dart';

Widget verticalLine(context, double height) {
  return Container(
    height: height,
    width: 4,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor),
  );
}

class ShortCutTitle extends StatelessWidget {
  const ShortCutTitle({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        verticalLine(context, 20.0),
        const SizedBox(
          width: 5,
          height: 35,
        ),
        Text(title,
            style: const TextStyle(
              letterSpacing: -0.7,
              wordSpacing: 1,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            )),
        const Spacer(),
      ],
    );
  }
}
