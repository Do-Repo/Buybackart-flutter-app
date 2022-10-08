import 'package:upwork_app/models/brands.dart';
import 'package:upwork_app/widgets/branditem_widget.dart';
import 'package:flutter/material.dart';

class BrandsView extends StatefulWidget {
  const BrandsView({Key? key, required this.children}) : super(key: key);
  final List<Brands> children;
  @override
  State<BrandsView> createState() => _BrandsViewState();
}

class _BrandsViewState extends State<BrandsView> {
  List<Widget> setBrand() {
    List<Widget> temp = [];
    for (var element in widget.children) {
      temp.add(BrandItem(brand: element));
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: (setBrand().isNotEmpty)
              ? GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: setBrand(),
                )
              : const Center(
                  child: Text("No brands available at the moment"),
                )),
    );
  }
}
