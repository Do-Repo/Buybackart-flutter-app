import 'package:upwork_app/models/brands.dart';
import 'package:upwork_app/pages/sellingPage/productchoice_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BrandItem extends StatelessWidget {
  const BrandItem({Key? key, required this.brand}) : super(key: key);
  final Brands brand;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductChoice(optionIndex: brand.id)));
      },
      child: SizedBox(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                style: BorderStyle.solid,
                width: 2,
                color: Theme.of(context).primaryColor),
          ),
          child: Center(
            child: CachedNetworkImage(
              imageUrl: brand.image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
