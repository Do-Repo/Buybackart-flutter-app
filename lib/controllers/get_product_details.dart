import 'dart:convert';

import 'package:upwork_app/constants.dart';
import 'package:upwork_app/models/create_order.dart';
import 'package:upwork_app/models/product_details.dart';

import 'package:http/http.dart' as http;

Future<ProductDetails> getProductDetails(int productIndex) async {
  String api = "$url/api/v1/catalogue/$productIndex/";
  final result = await http.get(Uri.parse(api));
  if (result.statusCode == 200) {
    var response = jsonDecode(result.body);
    return ProductDetails.fromMap(response);
  } else {
    throw Exception("${result.statusCode} ${result.reasonPhrase}");
  }
}

Future<ProductSum> getProductSum(String orderId, token) async {
  String api = "$url/api/v1/orders/get_device_report_by_order_id/$orderId/";
  final result = await http.get(Uri.parse(api), headers: {
    "Authorization": "Bearer $token",
  });
  if (result.statusCode == 200) {
    var response = jsonDecode(result.body);
    return ProductSum.fromMap(response);
  } else {
    throw Exception("${result.statusCode} ${result.reasonPhrase}");
  }
}
