import 'package:upwork_app/models/create_order.dart';
import 'package:upwork_app/models/sell_options.dart';
import 'package:upwork_app/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/optionitem_widget.dart';

class OptionsView extends StatefulWidget {
  const OptionsView({Key? key, required this.children}) : super(key: key);
  final List<SellOptions> children;
  @override
  State<OptionsView> createState() => _OptionsViewState();
}

class _OptionsViewState extends State<OptionsView> {
  List<Widget> setOption() {
    List<Widget> temp = [];
    temp.add(const SizedBox(width: 5));
    for (var element in widget.children) {
      temp.add(OptionItem(option: element));
    }
    temp.add(const SizedBox(width: 5));

    return temp;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CreateOrder>(context, listen: false).clearOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: ShortCutTitle(
              title: "Sell Now",
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: setOption(),
            ),
          ),
        ],
      ),
    );
  }
}
