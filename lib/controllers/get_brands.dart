import 'dart:convert';

import 'package:upwork_app/constants.dart';
import 'package:upwork_app/models/brands.dart';

import 'package:http/http.dart' as http;

Future<List<Brands>> getBrands(int optionIndex) async {
  String api = "$url/api/v1/categories/nested/$optionIndex/";
  final result = await http.get(Uri.parse(api));
  if (result.statusCode == 200) {
    List response = jsonDecode(result.body)['brands'];
    return response.map((e) => Brands.fromMap(e)).toList();
  } else {
    throw Exception("${result.statusCode} ${result.reasonPhrase}");
  }
}
