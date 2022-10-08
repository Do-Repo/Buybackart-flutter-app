import 'package:flutter/material.dart';

const url = "https://www.buybackart.com";
const contacturl = "https://www.buybackart.com/#/contact-us";
const privacyurl = url;
const refundurl = url;
const termsconditionsurl = "https://www.buybackart.com/#/terms-and-conditions";

List<BottomNavigationBarItem> items = const [
  BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
  BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About us"),
  BottomNavigationBarItem(icon: Icon(Icons.sell_outlined), label: "Sell now"),
  BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: "Blog"),
  BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
];

OutlineInputBorder textfieldBorder(BuildContext context) {
  return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2));
}
