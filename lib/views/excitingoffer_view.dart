import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/exciting_offers.dart';
import '../widgets/excitingoffer_widget.dart';
import '../widgets/title_widget.dart';

class ExcitingOffersView extends StatefulWidget {
  const ExcitingOffersView({Key? key, required this.children})
      : super(key: key);
  final List<ExcitingOffers> children;
  @override
  State<ExcitingOffersView> createState() => _ExcitingOffersViewState();
}

class _ExcitingOffersViewState extends State<ExcitingOffersView> {
  List<Widget> setOffers() {
    List<Widget> temp = [];
    for (var element in widget.children) {
      temp.add(ExcitingOffer(offer: element));
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: ShortCutTitle(
            title: "Exciting Offers",
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 500.h,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: setOffers(),
          ),
        ),
      ],
    );
  }
}
