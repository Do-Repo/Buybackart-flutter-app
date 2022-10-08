import 'package:badges/badges.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/create_order.dart';
import '../pages/sellingPage/productinfo_page.dart';

class ProductTracker extends StatefulWidget {
  const ProductTracker({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductTracker> createState() => _ProductTrackerState();
}

class _ProductTrackerState extends State<ProductTracker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => showModalBottomSheet(
          context: context, builder: (context) => ProductInfo())),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Badge(
            badgeColor: Theme.of(context).colorScheme.secondary,
            badgeContent: Text(
              optionCounts().toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            showBadge: (optionCounts() != 0) ? true : false,
            position: BadgePosition.topStart(),
            child: const Icon(Icons.phone_android_outlined)),
      ),
    );
  }

  int optionCounts() {
    final chosenProduct = Provider.of<CreateOrder>(context, listen: true);
    int count = 0;

    if (chosenProduct.deviceReport != null) {
      for (int i = 0; i < chosenProduct.deviceReport!.length; i++) {
        count++;
        count += chosenProduct.deviceReport![i].child.length;
      }
    }

    if (chosenProduct.accessories != null) {
      for (int i = 0; i < chosenProduct.accessories!.length; i++) {
        count++;
      }
    }

    if (chosenProduct.warrantyInStorage != null) {
      for (int i = 0; i < chosenProduct.warrantyInStorage!.length; i++) {
        count++;
      }
    }

    return count;
  }
}
