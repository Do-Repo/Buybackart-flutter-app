import 'dart:convert';

import 'package:upwork_app/constants.dart';
import 'package:upwork_app/models/sell_options.dart';

import 'package:http/http.dart' as http;

Future<List<SellOptions>> getSellOptions() async {
  String api = "$url/api/v1/categories/";
  final result = await http.get(Uri.parse(api));
  if (result.statusCode == 200) {
    List response = jsonDecode(result.body)['categories'];
    return response.map((e) => SellOptions.fromMap(e)).toList();
  } else {
    throw Exception("${result.statusCode} ${result.reasonPhrase}");
  }
}
