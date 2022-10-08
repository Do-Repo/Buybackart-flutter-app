import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:upwork_app/controllers/get_orders.dart';
import 'package:upwork_app/models/order.dart';
import 'package:upwork_app/models/user.dart';
import 'package:upwork_app/pages/sellingPage/shipping_page.dart';
import 'package:upwork_app/services/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upwork_app/widgets/title_widget.dart';

import '../constants.dart';
import '../views/change_password_view.dart';
import '../views/order_details_view.dart';
import '../widgets/appbar_widget.dart';
import 'authPages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.homeTabController}) : super(key: key);
  final TabController? homeTabController;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void logOut() {
    logoutUser().then((value) {
      if (value) {
        Provider.of<UserModel>(context, listen: false).removeUser();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something went wrong, try again later'),
        ));
      }
    });
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Something went wrong, try again later")));
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<UserModel>(context, listen: true);
    return Scaffold(
        body: CustomScrollView(slivers: [
      CustomAppbar(
        title: "Profile",
        actions: [
          IconButton(
              onPressed: logOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      SliverToBoxAdapter(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 180.sp,
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 1.sw - 300.sp,
                        child: AutoSizeText(
                          currentUser.name.toString(),
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 60.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 1.sw - 300.sp,
                        child: AutoSizeText(
                          " ${currentUser.email.toString()}",
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45.sp,
                              fontWeight: FontWeight.w300),
                        ),
                      )
                    ],
                  ),
                ),
                AboutMe(currentUser: currentUser),
                MyOrders(
                  userToken: currentUser.token.toString(),
                ),
                if (widget.homeTabController != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: ShortCutTitle(title: "More Options"),
                        ),
                        tabs(context, "Change Pin", "assets/icons/edit.png",
                            () {
                          showMaterialModalBottomSheet(
                              context: context,
                              builder: (context) => const ChangePin());
                        }),
                        tabs(context, "Services", "assets/icons/smartphone.png",
                            () {
                          widget.homeTabController!.animateTo(2);
                        }),
                        tabs(context, "Contact Us", "assets/icons/support.png",
                            () => _launchUrl(contacturl)),
                        tabs(
                            context,
                            "Privacy Policy",
                            "assets/icons/insurance.png",
                            () => _launchUrl(privacyurl)),
                        tabs(
                            context,
                            "Terms & Conditions",
                            "assets/icons/contract.png",
                            () => _launchUrl(termsconditionsurl)),
                        tabs(
                            context,
                            "Refund & Cancellation",
                            "assets/icons/refund.png",
                            () => _launchUrl(refundurl)),
                        const SizedBox(height: 20)
                      ],
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 150.sp,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 147.sp,
                        child: Icon(
                          Icons.person,
                          size: 150.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ]));
  }
}

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key, required this.userToken}) : super(key: key);
  final String userToken;
  @override
  State<MyOrders> createState() => _MyOrdersState();
}

ScrollController scrollController = ScrollController();

class _MyOrdersState extends State<MyOrders> {
  late Future<List<MiniOrder?>> future;
  double maxHeight = 150;

  @override
  void initState() {
    super.initState();
    future = bugFixWorkAround();
  }

  Future<List<MiniOrder?>> bugFixWorkAround() async {
    while (widget.userToken.toString() == "null") {
      await Future.delayed(const Duration(seconds: 1));
    }

    return getMiniOrder(widget.userToken);
  }

  Widget actionButton(String action, orderId) {
    return GestureDetector(
      onTap: () {
        if (action == "Un Finished") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ShippingInfo(orderid: orderId)));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: (action == "Un Finished") ? Colors.red[200] : null,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: Text(
            (action == "Un Finished") ? "Update" : "Updated",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Flexible(child: ShortCutTitle(title: "My Orders")),
                IconButton(
                    onPressed: () {
                      setState(() {
                        future = getMiniOrder(widget.userToken);
                      });
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Theme.of(context).primaryColor,
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        maxHeight = (maxHeight == double.infinity)
                            ? maxHeight = 150
                            : maxHeight = double.infinity;
                      });
                    },
                    icon: Icon(
                      (maxHeight == double.infinity)
                          ? Icons.fullscreen_exit
                          : Icons.fullscreen,
                      color: Theme.of(context).primaryColor,
                    ))
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(.05),
              constraints: BoxConstraints(
                  maxHeight: maxHeight, minWidth: double.infinity),
              child: FutureBuilder(
                  future: future,
                  builder: (context, AsyncSnapshot<List<MiniOrder?>> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const LinearProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            snapshot.error.toString(),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                              onPressed: (() => setState(() {
                                    future = getMiniOrder(widget.userToken);
                                  })),
                              child: Text(
                                "Try again",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ))
                        ],
                      );
                    } else if (snapshot.data!.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "You have no orders yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    } else {
                      List<DataRow> dataRows = [];
                      for (var element in snapshot.data!) {
                        dataRows.add(DataRow(cells: [
                          DataCell(Text(element!.id.toString())),
                          DataCell(Text(element.product.toString())),
                          DataCell(Text(element.status.toString())),
                          DataCell(Text(DateFormat()
                              .format(DateTime.parse(element.timestamp)))),
                          DataCell(actionButton(element.status, element.id)),
                          DataCell(Center(
                              child: IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () {
                              showMaterialModalBottomSheet(
                                  context: context,
                                  builder: (context) => OrderDetails(
                                        orderId: element.id.toString(),
                                      ));
                            },
                          ))),
                        ]));
                      }
                      return Scrollbar(
                        thumbVisibility: true,
                        controller: scrollController,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          child: FittedBox(
                            child: DataTable(
                              columns: const [
                                DataColumn(
                                    label: Text("ID",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Order",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Status",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Created",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("Action",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text("More Info",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ],
                              rows: dataRows,
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key, required this.currentUser}) : super(key: key);
  final UserModel currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ShortCutTitle(title: "About me"),
          ),
          RichText(
              text: TextSpan(
                  text: "Address: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  children: [
                TextSpan(
                    text: currentUser.address.toString(),
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ])),
          RichText(
              text: TextSpan(
                  text: "Phone number: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  children: [
                TextSpan(
                    text: currentUser.phone_number.toString(),
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ])),
          RichText(
              text: TextSpan(
                  text: "Email address: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  children: [
                TextSpan(
                    text: currentUser.email.toString(),
                    style: const TextStyle(fontWeight: FontWeight.normal))
              ]))
        ],
      ),
    );
  }
}
