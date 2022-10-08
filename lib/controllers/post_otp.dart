import 'dart:convert';
import 'package:upwork_app/models/user.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<bool?> requestOTP(String phone) async {
  String api = "$url/api/v1/accounts/send_otp_to_mobile/$phone/";

  final result = await http.post(Uri.parse(api));
  if (result.statusCode == 200) {
    return true;
  } else {
    var response = jsonDecode(result.body);
    throw Exception(response['detail'] ??
        result.statusCode.toString() + result.reasonPhrase.toString());
  }
}

Future<UserModel?> verifyOTP(String phone, otp) async {
  String api = "$url/api/v1/accounts/login_with_otp/$phone/$otp/";

  final result = await http.post(Uri.parse(api));
  if (result.statusCode == 200) {
    var response = jsonDecode(result.body);
    return UserModel.fromMap(response);
  } else {
    var response = jsonDecode(result.body);
    throw Exception(response['detail'] ??
        result.statusCode.toString() + result.reasonPhrase.toString());
  }
}
