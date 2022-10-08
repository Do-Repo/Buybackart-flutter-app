import 'package:upwork_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> saveUser(UserModel userModel) async {
  bool result = false;
  SharedPreferences sharedUser = await SharedPreferences.getInstance();
  String user = userModel.toJson();
  sharedUser.setString('CURRENTUSER', user).then((value) => result = value);
  return result;
}

Future<void> setFirstTime(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('FIRSTTIME', value);
}

Future<bool> getFirstTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('FIRSTTIME') ?? true;
}

Future<bool> logoutUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.remove('CURRENTUSER');
}

Future<UserModel?> getSavedUser() async {
  SharedPreferences sharedUser = await SharedPreferences.getInstance();
  String? e = sharedUser.getString("CURRENTUSER");
  if (e == null || e.isEmpty) {
    return null;
  } else {
    var user = UserModel.fromJson(e);
    return user;
  }
}
