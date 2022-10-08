import 'package:upwork_app/pages/errorpage.dart';
import 'package:upwork_app/widgets/animator_widget.dart';
import 'package:flutter/material.dart';

import '../controllers/get_banners.dart';
import '../controllers/get_exciting_offers.dart';
import '../controllers/get_sell_options.dart';
import '../views/banners_view.dart';
import '../views/customer_view.dart';
import '../views/excitingoffer_view.dart';
import '../views/options_view.dart';
import '../views/sellingsimpler_view.dart';
import '../views/whysection_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  Future<List<dynamic>> futures =
      Future.wait([getBanners(), getExcitingOffers(), getSellOptions()]);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: FutureBuilder(
        future: futures,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return ErrorScreen(
                snapshot: snapshot,
                onPressed: () => setState(() {
                      futures = Future.wait([
                        getBanners(),
                        getExcitingOffers(),
                        getSellOptions()
                      ]);
                    }));
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BannersView(children: snapshot.data![0]),
                  WidgetAnimator(
                      child: OptionsView(children: snapshot.data![2])),
                  WidgetAnimator(child: SellingSimpler()),
                  WidgetAnimator(
                      child: ExcitingOffersView(children: snapshot.data![1])),
                  const WhySection(),
                  const CustomerTestimonials()
                ],
              ),
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
