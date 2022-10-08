import 'dart:convert';
import 'package:upwork_app/models/order.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<Order?> createOrder(String orderJson, token) async {
  String api = "$url/api/v1/orders/create_order/";

  final result = await http.post(Uri.parse(api),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: orderJson);
  if (result.statusCode == 200) {
    var response = jsonDecode(result.body);
    return Order.fromMap(response);
  } else {
    var response = jsonDecode(result.body);
    throw Exception(response['detail'] ??
        result.statusCode.toString() + result.reasonPhrase.toString());
  }
}

Future<FinalizedOrder> finalizeOffer(
    int orderId,
    String token,
    int refferalCode,
    String address,
    street,
    landmark,
    state,
    city,
    date,
    time,
    payOption) async {
  String api = "$url/api/v1/orders/update_order/$orderId/";

  final result = await http.patch(Uri.parse(api),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "refferalCode": refferalCode,
        "address": address,
        "street": street,
        "landmark": landmark,
        "state": state,
        "city": city,
        "date": date,
        "time": time,
        "payOption": payOption
      }));
  if (result.statusCode == 200) {
    var response = jsonDecode(result.body);
    return FinalizedOrder.fromMap(response);
  } else {
    var response = jsonDecode(result.body);
    throw Exception(response['detail'] ??
        result.statusCode.toString() + result.reasonPhrase.toString());
  }
}
