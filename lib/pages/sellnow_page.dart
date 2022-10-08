import 'package:upwork_app/models/create_order.dart';
import 'package:upwork_app/pages/sellingPage/brandchoice_page.dart';
import 'package:upwork_app/widgets/animator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../controllers/get_sell_options.dart';
import '../models/sell_options.dart';
import 'errorpage.dart';

class SellNowPage extends StatefulWidget {
  const SellNowPage({Key? key}) : super(key: key);

  @override
  State<SellNowPage> createState() => _SellNowPageState();
}

class _SellNowPageState extends State<SellNowPage>
    with AutomaticKeepAliveClientMixin {
  Future<List<SellOptions>> future = getSellOptions();

  List<Widget> setOptions(AsyncSnapshot<List<SellOptions>> snapshot) {
    List<Widget> temp = [];
    for (var element in snapshot.data!) {
      temp.add(WidgetAnimator(
        child: GestureDetector(
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BrandChoice(option: element)));
            }),
            child: Container(
                margin: const EdgeInsets.only(
                    top: 10, left: 15, right: 15, bottom: 5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 3),
                          blurRadius: 5,
                          color: Colors.grey.withOpacity(0.5))
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(children: [
                  CachedNetworkImage(
                    imageUrl: element.image,
                    height: 150.sp,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    element.title,
                    style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.7),
                  ),
                ]))),
      ));
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    double fakeAppbarHeight = 160 -
        AppBar().preferredSize.height +
        MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sell now"),
      ),
      body: FutureBuilder(
        future: future,
        builder: ((context, AsyncSnapshot<List<SellOptions>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: fakeAppbarHeight,
                  color: Theme.of(context).primaryColor,
                ),
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: fakeAppbarHeight,
                  color: Theme.of(context).primaryColor,
                ),
                Expanded(
                  child: ErrorScreen(
                      snapshot: snapshot,
                      onPressed: () {
                        setState(() => future = getSellOptions());
                      }),
                )
              ],
            );
          } else {
            return SingleChildScrollView(
                child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: fakeAppbarHeight,
                  color: Theme.of(context).primaryColor,
                ),
                Column(
                  children: [
                    const SizedBox(height: 60),
                    ...setOptions(snapshot),
                  ],
                ),
              ],
            ));
          }
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
