import 'dart:convert';

import 'package:upwork_app/models/order.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<List<MiniOrder?>> getMiniOrder(String token) async {
  String api = "$url/api/v1/orders/my_orders/";

  final result = await http.get(Uri.parse(api), headers: {
    "Authorization": "Bearer $token",
    "Content-Type": "application/json"
  });
  if (result.statusCode == 200) {
    List response = jsonDecode(result.body);
    return response.map((e) => MiniOrder.fromMap(e)).toList();
  } else {
    var response = jsonDecode(result.body);
    throw Exception(response['detail'] ??
        result.statusCode.toString() + result.reasonPhrase.toString());
  }
}

Future<FinalizedOrder> getOrder(String token, orderid) async {
  String api = "$url/api/v1/orders/$orderid/";

  final result = await http.get(Uri.parse(api), headers: {
    "Authorization": "Bearer $token",
  });
  if (result.statusCode == 200) {
    var response = jsonDecode(result.body);
    return FinalizedOrder.fromMap(response);
  } else {
    var response = jsonDecode(result.body);
    throw Exception(response['detail'] ??
        result.statusCode.toString() + result.reasonPhrase.toString());
  }
}
