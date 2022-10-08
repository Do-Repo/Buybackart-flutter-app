import 'dart:convert';

import 'package:upwork_app/models/search.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<SearchModel> getSearch(String keyword, int page) async {
  String api = "$url/api/v1/catalogue/?keyword=$keyword&page=$page";
  final result = await http.get(Uri.parse(api));
  if (result.statusCode == 200) {
    var response = jsonDecode(result.body);
    return SearchModel.fromMap(response);
  } else {
    throw Exception("${result.statusCode} ${result.reasonPhrase}");
  }
}
