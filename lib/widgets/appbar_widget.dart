import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key, required this.title, this.actions})
      : super(key: key);
  final String title;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 160,
      elevation: 4,
      pinned: true,
      actions: actions,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 2,
        centerTitle: false,
        titlePadding: const EdgeInsets.all(10),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
