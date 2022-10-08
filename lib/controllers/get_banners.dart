import 'dart:convert';

import 'package:upwork_app/constants.dart';
import 'package:upwork_app/models/banners.dart';

import 'package:http/http.dart' as http;

Future<List<Banners>> getBanners() async {
  String api = "$url/api/v1/fixtures/banners/";
  final result = await http.get(Uri.parse(api));
  if (result.statusCode == 200) {
    List response = jsonDecode(result.body);
    return response.map((e) => Banners.fromMap(e)).toList();
  } else {
    throw Exception("${result.statusCode} ${result.reasonPhrase}");
  }
}
