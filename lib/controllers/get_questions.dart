import 'dart:convert';

import 'package:upwork_app/constants.dart';
import 'package:upwork_app/models/questionnaire.dart';

import 'package:http/http.dart' as http;

Future<List<Questionnaire>> getQuestions(int optionIndex) async {
  String api = "$url/api/v1/questionnaire/get_special_questions/$optionIndex";
  final result = await http.get(Uri.parse(api));
  if (result.statusCode == 200) {
    List response = jsonDecode(result.body);
    return response.map((e) => Questionnaire.fromMap(e)).toList();
  } else {
    throw Exception("${result.statusCode} ${result.reasonPhrase}");
  }
}

Future<List<WarrantyQuestion>> getWarrantyQuestions() async {
  String api = "$url/api/v1/catalogue/warranty/list/";
  final result = await http.get(Uri.parse(api));
  if (result.statusCode == 200) {
    List response = jsonDecode(result.body);
    return response.map((e) => WarrantyQuestion.fromMap(e)).toList();
  } else {
    throw Exception("${result.statusCode} ${result.reasonPhrase}");
  }
}
