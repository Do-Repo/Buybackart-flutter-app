import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controllers/get_states.dart';
import '../../controllers/post_create_order.dart';
import '../../models/order.dart';
import '../../models/states.dart';
import '../../models/user.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/order_confirmed_sheet.dart';
import '../../widgets/title_widget.dart';
import '../errorpage.dart';

class ShippingInfo extends StatefulWidget {
  const ShippingInfo({Key? key, required this.orderid}) : super(key: key);
  final int orderid;
  @override
  State<ShippingInfo> createState() => _ShippingInfoState();
}

class _ShippingInfoState extends State<ShippingInfo> {
  late Future<List<States>> future;
  int stateValue = -1, cityValue = -1, timeValue = -1, paymentValue = -1;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  final _formKey = GlobalKey<FormState>();
  var addressTextController = TextEditingController();
  var streetTextController = TextEditingController();
  var landMarkTextController = TextEditingController();
  var dateTextController = TextEditingController();
  var timeTextController = TextEditingController();
  var refferalTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    future = getStates();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: selectedDate.add(const Duration(days: 365)));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateTextController.text = DateFormat("yyyy-MM-dd").format(picked);
      });
    }
  }

  List<String> timings = [
    "10:00 AM - 12:00 PM",
    "12:00 PM - 02:00 PM",
    "02:00 PM - 04:00 PM",
    "04:00 PM - 08:00 PM"
  ];
  List<DropdownMenuItem> setTimings() {
    return [
      DropdownMenuItem(
          enabled: false,
          value: -1,
          child: Text("Select Time Slot",
              style: TextStyle(color: Theme.of(context).hintColor))),
      DropdownMenuItem(value: 0, child: Text(timings[0])),
      DropdownMenuItem(value: 1, child: Text(timings[1])),
      DropdownMenuItem(value: 2, child: Text(timings[2])),
      DropdownMenuItem(value: 3, child: Text(timings[3])),
    ];
  }

  List<String> methods = [
    "Google Pay",
    "Phone Pay",
    "PayTm",
    "Bank Transfer",
    "Other"
  ];
  List<DropdownMenuItem> setPaymentMethods() {
    return [
      DropdownMenuItem(
          enabled: false,
          value: -1,
          child: Text("Select Payment Method",
              style: TextStyle(color: Theme.of(context).hintColor))),
      DropdownMenuItem(value: 0, child: Text(methods[0])),
      DropdownMenuItem(value: 1, child: Text(methods[1])),
      DropdownMenuItem(value: 2, child: Text(methods[2])),
      DropdownMenuItem(value: 3, child: Text(methods[3])),
      DropdownMenuItem(value: 4, child: Text(methods[4]))
    ];
  }

  List<DropdownMenuItem> setStates(AsyncSnapshot<List<States>> snapshot) {
    List<DropdownMenuItem> reasonList = [
      DropdownMenuItem(
          enabled: false,
          value: -1,
          child: Text("Select a state",
              style: TextStyle(color: Theme.of(context).hintColor)))
    ];

    for (var element in snapshot.data!) {
      reasonList.add(
          DropdownMenuItem<int>(value: element.id, child: Text(element.name)));
    }
    return reasonList;
  }

  List<DropdownMenuItem> setCities(
      AsyncSnapshot<List<States>> snapshot, int stateId) {
    List<DropdownMenuItem> reasonList = [
      DropdownMenuItem(
          enabled: false,
          value: -1,
          child: Text("Select a city",
              style: TextStyle(color: Theme.of(context).hintColor)))
    ];

    if (stateId == -1) return reasonList;

    snapshot.data!
        .firstWhere((element) => element.id == stateId)
        .cities
        .forEach((element) {
      reasonList
          .add(DropdownMenuItem(value: element.id, child: Text(element.name)));
    });
    return reasonList;
  }

  void setFinalOffer(AsyncSnapshot<List<States>> snapshot) async {
    var user = Provider.of<UserModel>(context, listen: false);
    await finalizeOffer(
            widget.orderid,
            user.token!,
            (refferalTextController.text.isEmpty)
                ? 0
                : int.parse(refferalTextController.text),
            addressTextController.text,
            streetTextController.text,
            landMarkTextController.text,
            snapshot.data!
                .firstWhere((element) => element.id == stateValue)
                .name,
            snapshot.data!
                .firstWhere((element) => element.id == stateValue)
                .cities
                .firstWhere((element) => element.id == cityValue)
                .name,
            DateTime.parse(dateTextController.text).toIso8601String(),
            timings[timeValue],
            methods[paymentValue])
        .then((value) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      showModalBottomSheet(
              context: context, builder: (context) => const OrderConfirmed())
          .onError((error, stackTrace) =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ErrorScreen(
                      snapshot: snapshot,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }))));
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<UserModel>(context);

    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: future,
          builder: ((context, AsyncSnapshot<List<States>> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return ErrorScreen(
                  snapshot: snapshot,
                  onPressed: () => setState(() => future = getStates()));
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const ShortCutTitle(title: "Personal Information"),
                        TextFormField(
                          initialValue: currentUser.name,
                          enabled: false,
                          decoration:
                              const InputDecoration(label: Text("Name")),
                        ),
                        TextFormField(
                          initialValue: currentUser.email,
                          enabled: false,
                          decoration: const InputDecoration(
                              label: Text("Email Address")),
                        ),
                        TextFormField(
                          initialValue: currentUser.phone_number,
                          enabled: false,
                          decoration: const InputDecoration(
                              label: Text("Phone number")),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: ShortCutTitle(title: "Pickup Address"),
                        ),
                        TextFormField(
                          controller: addressTextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              label: Text("Address"),
                              hintText: "Flat No. / Office address / Flore"),
                        ),
                        TextFormField(
                          controller: streetTextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              label: Text("Street"), hintText: "Street No."),
                        ),
                        TextFormField(
                          controller: landMarkTextController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              label: Text("Nearest Landmark"),
                              hintText: "Any Nearest Landmark"),
                        ),
                        DropdownButtonFormField(
                            value: stateValue,
                            validator: (dynamic value) {
                              if (value == null || value == -1) {
                                return 'Field required';
                              }
                              return null;
                            },
                            items: setStates(snapshot),
                            onChanged: (dynamic val) => setState(() {
                                  stateValue = val;
                                  cityValue = -1;
                                })),
                        DropdownButtonFormField(
                            value: cityValue,
                            validator: (dynamic value) {
                              if (value == null || value == -1) {
                                return 'Field required';
                              }
                              return null;
                            },
                            items: setCities(snapshot, stateValue),
                            onChanged: (dynamic val) =>
                                setState(() => cityValue = val)),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: ShortCutTitle(title: "Schedule Pickup"),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  selectDate(context);
                                },
                                child: IgnorePointer(
                                  child: TextFormField(
                                    controller: dateTextController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Field required';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(Icons.calendar_month,
                                            color:
                                                Theme.of(context).primaryColor),
                                        label: const Text("Select Date")),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                                child: DropdownButtonFormField(
                                    validator: (dynamic value) {
                                      if (value == null || value == -1) {
                                        return 'Field required';
                                      }
                                      return null;
                                    },
                                    icon: Icon(Icons.timer_outlined,
                                        color: Theme.of(context).primaryColor),
                                    decoration: const InputDecoration(
                                        label: Text("Select Time")),
                                    value: timeValue,
                                    items: setTimings(),
                                    onChanged: (dynamic val) => setState(() {
                                          timeValue = val;
                                        })))
                          ],
                        ),
                        DropdownButtonFormField(
                            value: paymentValue,
                            validator: (dynamic value) {
                              if (value == null || value == -1) {
                                return 'Field required';
                              }
                              return null;
                            },
                            items: setPaymentMethods(),
                            onChanged: (dynamic val) => setState(() {
                                  paymentValue = val;
                                })),
                        TextField(
                          controller: refferalTextController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          decoration: const InputDecoration(
                              label: Text("Refferal Code ( Optional )"),
                              hintText: "Refferal Code"),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Button(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setFinalOffer(snapshot);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Confirm",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 50.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
        ));
  }
}
