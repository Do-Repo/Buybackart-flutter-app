import 'dart:convert';
import 'package:upwork_app/models/user.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<UserModel?> editPassword(String pin, phone, token) async {
  String api = "$url/api/v1/accounts/user/change_pin/$phone/";

  final result = await http.patch(Uri.parse(api),
      headers: {"Authorization": "Bearer $token"},
      body: {'pin': pin.toString()});
  if (result.statusCode == 200) {
    var response = jsonDecode(result.body);
    return UserModel.fromMap(response);
  } else {
    var response = jsonDecode(result.body);
    throw Exception(response['detail'] ??
        result.statusCode.toString() + result.reasonPhrase.toString());
  }
}
