import 'dart:convert';
import 'package:upwork_app/models/user.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<UserModel?> additionalInfo(String phone, email, name, token) async {
  String api = "$url/api/v1/accounts/user/name_email_update/$phone/";

  final result = await http.put(Uri.parse(api),
      headers: {"Authorization": "Bearer $token"},
      body: {'phone': phone, 'email': email, 'name': name});
  if (result.statusCode == 200) {
    var response = jsonDecode(result.body);
    return UserModel.fromMap(response);
  } else {
    var response = jsonDecode(result.body);
    throw Exception(response['detail'] ??
        result.statusCode.toString() + result.reasonPhrase.toString());
  }
}
