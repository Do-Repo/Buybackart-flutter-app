import 'dart:async';

import 'package:upwork_app/models/banners.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/searchbar_widget.dart';

class BannersView extends StatefulWidget {
  const BannersView({Key? key, required this.children}) : super(key: key);
  final List<Banners> children;
  @override
  State<BannersView> createState() => _BannersViewState();
}

class _BannersViewState extends State<BannersView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.children.length, vsync: this);
    timer = Timer.periodic(const Duration(seconds: 5), ((timer) {
      if (tabController.index == tabController.length - 1) {
        tabController.animateTo(0);
      } else {
        tabController.animateTo(tabController.index + 1);
      }
    }));
  }

  @override
  void dispose() {
    timer.cancel();
    tabController.dispose();
    super.dispose();
  }

  List<Widget> setBanners() {
    List<Widget> temp = [];
    for (var element in widget.children) {
      temp.add(CachedNetworkImage(
        imageUrl: element.mobile_image,
        fit: BoxFit.fitHeight,
      ));
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: 0.33.sh,
            width: double.infinity,
            child:
                TabBarView(controller: tabController, children: setBanners())),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 0.29.sh),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: SearchTextfield(isHomepage: true),
            ),
          ],
        )
      ],
    );
  }
}
