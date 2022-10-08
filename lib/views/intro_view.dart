import 'package:upwork_app/widgets/introscreen_widget.dart';
import 'package:flutter/material.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: tabController, children: [
        IntroScreen(
            index: 0,
            tabController: tabController,
            image: "assets/images/cash.png",
            title: "Sell Your Devices For Instant Cash",
            firstSubtitle: "Assured Value",
            secondSubtitle: "Doorstep Service",
            thirdSubtitle: "Instant Cash"),
        IntroScreen(
            index: 1,
            tabController: tabController,
            image: "assets/images/repair.png",
            title: "Repair Your Devices At Doorstep",
            firstSubtitle: "30 Minute Repair",
            secondSubtitle: "Doorstep Service",
            thirdSubtitle: "6 Months Warranty"),
        IntroScreen(
            index: 2,
            tabController: tabController,
            image: "assets/images/accessoires.png",
            title: "Buy Accessories & Refurbished Gadgets",
            firstSubtitle: "Accessories",
            secondSubtitle: "Refurbished Smartphones",
            thirdSubtitle: "Refurbished Laptops"),
      ]),
    );
  }
}
