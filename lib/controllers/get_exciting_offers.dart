import 'dart:convert';

import 'package:upwork_app/constants.dart';

import '../models/exciting_offers.dart';
import 'package:http/http.dart' as http;

Future<List<ExcitingOffers>> getExcitingOffers() async {
  String api = "$url/api/v1/catalogue/exciting-offers/list/";
  final result = await http.get(Uri.parse(api));
  if (result.statusCode == 200) {
    List response = jsonDecode(result.body);
    return response.map((e) => ExcitingOffers.fromMap(e)).toList();
  } else {
    throw Exception("${result.statusCode} ${result.reasonPhrase}");
  }
}
