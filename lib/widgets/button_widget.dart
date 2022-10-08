import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.color,
      required this.onPressed,
      required this.child,
      this.enabled})
      : super(key: key);
  final Widget child;
  final Color color;
  final VoidCallback onPressed;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (enabled ?? true) ? onPressed : null,
      child: Container(
          decoration: BoxDecoration(
              color: (enabled ?? true) ? color : color.withOpacity(0.6),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          margin: const EdgeInsets.all(10),
          child: child),
    );
  }
}
