import 'package:upwork_app/controllers/get_products.dart';
import 'package:upwork_app/pages/errorpage.dart';
import 'package:upwork_app/views/devices_view.dart';
import 'package:flutter/material.dart';

import '../../widgets/searchbar_widget.dart';
import '../../widgets/title_widget.dart';

class ProductChoice extends StatefulWidget {
  const ProductChoice({Key? key, required this.optionIndex}) : super(key: key);
  final int optionIndex;
  @override
  State<ProductChoice> createState() => _ProductChoiceState();
}

class _ProductChoiceState extends State<ProductChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search your device"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: FutureBuilder(
            future: Future.wait([getProducts(widget.optionIndex)]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: ErrorScreen(
                        snapshot: snapshot,
                        onPressed: () {
                          setState(() {});
                        }));
              } else {
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        const SearchTextfield(),
                        const SizedBox(height: 20),
                        const ShortCutTitle(title: "Or pick your device"),
                        DevicesView(children: snapshot.data![0])
                      ],
                    ));
              }
            },
          )),
    );
  }
}
