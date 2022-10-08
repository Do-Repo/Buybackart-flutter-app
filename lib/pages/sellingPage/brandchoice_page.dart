import 'package:upwork_app/models/sell_options.dart';
import 'package:upwork_app/pages/errorpage.dart';
import 'package:upwork_app/widgets/searchbar_widget.dart';
import 'package:upwork_app/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/get_brands.dart';
import '../../models/create_order.dart';
import '../../views/brands_view.dart';

class BrandChoice extends StatefulWidget {
  const BrandChoice({Key? key, required this.option}) : super(key: key);
  final SellOptions option;
  @override
  State<BrandChoice> createState() => _BrandChoiceState();
}

class _BrandChoiceState extends State<BrandChoice> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CreateOrder>(context, listen: false)
          .setChosenOption(widget.option);
      Provider.of<CreateOrder>(context, listen: false).clearOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search your device"),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: FutureBuilder(
            future: Future.wait([getBrands(widget.option.id)]),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      const SearchTextfield(),
                      const SizedBox(height: 20),
                      const ShortCutTitle(title: "Or pick a brand"),
                      BrandsView(children: snapshot.data![0])
                    ],
                  ),
                );
              }
            },
          )),
    );
  }
}
