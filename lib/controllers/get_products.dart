import 'dart:convert';

import 'package:upwork_app/constants.dart';
import 'package:upwork_app/models/products.dart';

import 'package:http/http.dart' as http;

Future<List<Product>> getProducts(int brandIndex) async {
  String api = "$url/api/v1/brands/nested/$brandIndex/";
  final result = await http.get(Uri.parse(api));
  if (result.statusCode == 200) {
    List response = jsonDecode(result.body)['products'];
    return response.map((e) => Product.fromMap(e)).toList();
  } else {
    throw Exception("${result.statusCode} ${result.reasonPhrase}");
  }
}
