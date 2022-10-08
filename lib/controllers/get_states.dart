import 'dart:convert';

import 'package:upwork_app/models/states.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

Future<List<States>> getStates() async {
  String api = "$url/api/v1/fixtures/states_and_cities/";
  final result = await http.get(Uri.parse(api));
  if (result.statusCode == 200) {
    List response = jsonDecode(result.body);
    return response.map((e) => States.fromMap(e)).toList();
  } else {
    throw Exception("${result.statusCode} ${result.reasonPhrase}");
  }
}
