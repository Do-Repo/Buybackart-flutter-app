import 'dart:convert';
import 'package:upwork_app/models/user.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<UserModel?> login(String phone, password) async {
  String api = "$url/api/v1/accounts/login/";

  final result = await http.post(Uri.parse(api), body: {
    'phone_number': phone,
    'password': password,
  });
  if (result.statusCode == 200) {
    var response = jsonDecode(result.body);
    return UserModel.fromMap(response);
  } else {
    var response = jsonDecode(result.body);
    throw Exception(response['detail'] ??
        result.statusCode.toString() + result.reasonPhrase.toString());
  }
}
