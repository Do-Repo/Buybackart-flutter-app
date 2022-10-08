import 'dart:convert';

import 'package:upwork_app/constants.dart';
import 'package:http/http.dart' as http;

Future<int> orderInit(int productId, varId) async {
  String api = "$url/api/v1/orders/order_init/";

  final result = await http.post(Uri.parse(api),
      body: {'id': productId.toString(), 'varId': varId.toString()});
  var response = jsonDecode(result.body);
  if (result.statusCode == 200) {
    return response['prod_category'];
  } else {
    throw Exception(response['detail'] ??
        result.statusCode.toString() + result.reasonPhrase.toString());
  }
}
