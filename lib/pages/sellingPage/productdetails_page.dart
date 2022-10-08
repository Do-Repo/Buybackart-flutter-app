import 'package:auto_size_text/auto_size_text.dart';
import 'package:upwork_app/controllers/get_product_details.dart';
import 'package:upwork_app/models/create_order.dart';
import 'package:upwork_app/models/product_details.dart';
import 'package:upwork_app/pages/errorpage.dart';
import 'package:upwork_app/pages/sellingPage/questionsform_page.dart';
import 'package:upwork_app/widgets/button_widget.dart';
import 'package:upwork_app/widgets/title_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.optionIndex}) : super(key: key);
  final int optionIndex;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedIndex = -1;
  bool hasChosen = false;
  late Future<ProductDetails> future;

  void setChosenProduct(ProductDetails value) {
    final chosenProduct = Provider.of<CreateOrder>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chosenProduct.setChosenProduct(value);
    });
  }

  @override
  void initState() {
    super.initState();
    future = getProductDetails(widget.optionIndex);
  }

  @override
  Widget build(BuildContext context) {
    final chosenProduct = Provider.of<CreateOrder>(context, listen: false);
    return WillPopScope(
      onWillPop: (hasChosen)
          ? () {
              setState(() => hasChosen = false);
              return Future.value(false);
            }
          : () {
              return Future.value(true);
            },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pick your variant"),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomScrollView(slivers: [
              SliverFillRemaining(
                  child: FutureBuilder(
                future: future,
                builder: (context, AsyncSnapshot<ProductDetails?> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return ErrorScreen(
                      snapshot: snapshot,
                      onPressed: () {
                        setState(() {
                          future = getProductDetails(widget.optionIndex);
                        });
                      },
                    );
                  } else {
                    setChosenProduct(snapshot.data!);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShortCutTitle(title: snapshot.data!.name),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: snapshot.data!.image,
                                  height: 600.h,
                                ),
                                AnimatedSize(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                  child: (hasChosen)
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AutoSizeText(
                                                chosenProduct
                                                    .chosenProduct!.name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 70.sp),
                                              ),
                                              AutoSizeText(
                                                  chosenProduct
                                                      .getChosenVariant()
                                                      .variant,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 40.sp)),
                                              const Divider(thickness: 2),
                                              AutoSizeText("Get Upto:",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 60.sp)),
                                              AutoSizeText(
                                                "₹${chosenProduct.getChosenVariant().market_retail_price.toString()}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 90.sp),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                            fit: FlexFit.tight,
                            child: (hasChosen)
                                ? Container()
                                : variantChoices(snapshot)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Button(
                            color: Theme.of(context).primaryColor,
                            enabled: (selectedIndex != -1),
                            onPressed: (hasChosen)
                                ? () {
                                    chosenProduct.clearChoices();
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const QuestionsForm()));
                                  }
                                : () => setState(() => hasChosen = true),
                            child: Text(
                              (hasChosen) ? 'GET ACCURATE VALUE' : 'CONTINUE',
                              style: TextStyle(
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                },
              )),
            ])),
      ),
    );
  }

  Widget variantChoices(AsyncSnapshot<ProductDetails?> snapshot) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ShortCutTitle(title: "Choose a variant"),
        Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: setVariants(snapshot.data!.variants),
              ),
            )),
      ],
    );
  }

  List<Widget> setVariants(List<Variants> variants) {
    List<Widget> temp = [];
    final chosenProduct = Provider.of<CreateOrder>(context, listen: false);
    for (var element in variants) {
      temp.add(GestureDetector(
        onTap: () {
          chosenProduct.setVarId(element.id);
          setState(() {
            selectedIndex = variants.indexOf(element);
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
          decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid),
              color: Theme.of(context).primaryColor.withOpacity(
                  (selectedIndex == variants.indexOf(element)) ? 0.3 : 0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              (selectedIndex == variants.indexOf(element))
                  ? const Icon(Icons.radio_button_checked_outlined)
                  : const Icon(Icons.radio_button_off_outlined),
              const Spacer(),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    element.variant,
                    style:
                        TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ),
      ));
    }
    return temp;
  }
}
