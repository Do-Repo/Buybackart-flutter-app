import 'package:upwork_app/models/products.dart';
import 'package:upwork_app/pages/sellingPage/productdetails_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DeviceItem extends StatelessWidget {
  const DeviceItem({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Details(optionIndex: product.id)));
      }),
      child: SizedBox(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  style: BorderStyle.solid,
                  width: 3,
                  color: Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(product.name),
              )
            ],
          ),
        ),
      ),
    );
  }
}
