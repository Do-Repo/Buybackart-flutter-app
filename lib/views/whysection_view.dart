import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

class WhySection extends StatefulWidget {
  const WhySection({Key? key}) : super(key: key);

  @override
  State<WhySection> createState() => _WhySectionState();
}

class _WhySectionState extends State<WhySection> {
  PageController tabController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    tabController.addListener(() {
      setState(() {
        currentPage = tabController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).primaryColor.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (currentPage != 0)
                    ? GestureDetector(
                        onTap: () => tabController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut),
                        child: const Icon(Icons.arrow_back_ios))
                    : const SizedBox(
                        width: 24,
                      ),
                const Text(
                  "Why BuyBacKart",
                  style: TextStyle(
                      letterSpacing: -0.7,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
                (currentPage != items.length - 1)
                    ? GestureDetector(
                        onTap: () => tabController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut),
                        child: const Icon(Icons.arrow_forward_ios))
                    : const SizedBox(
                        width: 24,
                      ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: ExpandablePageView(
                  controller: tabController, children: items)),
        ],
      ),
    );
  }

  List<Widget> items = const [
    Item(
      image: "assets/icons/responsive.png",
      title: "We Buy It All",
      text:
          "We buy all types of pre-owned portable devices, including phones, tablets, laptops, and smartwatches.",
    ),
    Item(
      image: "assets/icons/guarantee.png",
      title: "The best price is GUARANTEED",
      text:
          "We don’t make tall claims. Buybackart is known for offering the best prices for all pre-owned devices. Our valued customers are the biggest witness to our claim.",
    ),
    Item(
      image: "assets/icons/evaluation.png",
      title: "Evaluate your device yourself",
      text:
          "We allow our customers to evaluate their devices on our website with the help of a smart evaluator. Just answer a couple of questions to get the best and exact value instantly.",
    ),
    Item(
      image: "assets/icons/clock.png",
      title: "We offer different time slots",
      text:
          "We also give our customers the privilege to pick their favorite time slot. You can find multiple time slots for a particular day to pick. Upon picking a convenient slot and placing an order, our team will get in touch with you to pick up your device.",
    ),
    Item(
        image: "assets/icons/delivery.png",
        title: "Get your device picked up from your doorstep",
        text:
            "Our field executive will come to your doorstep to inspect and pick up your device."),
    Item(
        image: "assets/icons/pay.png",
        title: "Get instant and safe payment on the spot",
        text:
            "Upon successful inspection and pickup of your device, the money will be transferred to your chosen payment method. We keep customers’ information completely confidential and leave no stone unturned to follow safe financial transactions.")
  ];
}

class Item extends StatelessWidget {
  const Item(
      {Key? key, required this.image, required this.title, required this.text})
      : super(key: key);
  final String image, title, text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconWidget(context, image),
          const SizedBox(width: 10),
          textWidget(title, text)
        ],
      ),
    );
  }

  Flexible textWidget(String title, String text) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              title,
              style: const TextStyle(
                  letterSpacing: -0.7,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w700,
                  fontSize: 17),
            ),
          ),
          const Divider(
            endIndent: 200,
            thickness: 2,
          ),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                  letterSpacing: -0.7,
                  wordSpacing: 1,
                  fontWeight: FontWeight.w400,
                  fontSize: 17),
            ),
          )
        ],
      ),
    );
  }

  CircleAvatar iconWidget(BuildContext context, String image) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      radius: 40,
      child: CircleAvatar(
        radius: 38,
        backgroundColor: Colors.white.withOpacity(1),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
