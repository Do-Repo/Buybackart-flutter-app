import 'package:upwork_app/models/products.dart';
import 'package:upwork_app/widgets/productitem_widget.dart';
import 'package:flutter/material.dart';

class DevicesView extends StatefulWidget {
  const DevicesView({Key? key, required this.children}) : super(key: key);
  final List<Product> children;
  @override
  State<DevicesView> createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  List<Widget> setDevice() {
    List<Widget> temp = [];
    for (var element in widget.children) {
      temp.add(DeviceItem(product: element));
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: setDevice(),
        ),
      ),
    );
  }
}
