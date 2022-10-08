import 'dart:convert';

import 'package:flutter/cupertino.dart';

// ignore_for_file: non_constant_identifier_names

class UserModel extends ChangeNotifier {
  int? id;
  String? name;
  String? phone_number;
  String? email;
  String? address;
  String? city;
  String? postalCode;
  String? country;
  bool? isPhoneVerified;
  bool? isEmailVerified;
  bool? isAdmin;
  String? token;
  String? refresh;
  String? access;

  void setUser(UserModel user) {
    id = user.id;
    name = user.name;
    phone_number = user.phone_number;
    email = user.email;
    address = user.address;
    city = user.city;
    postalCode = user.postalCode;
    country = user.country;
    isPhoneVerified = user.isPhoneVerified;
    isEmailVerified = user.isEmailVerified;
    isAdmin = user.isAdmin;
    token = user.token;
    refresh = user.refresh;
    access = user.access;
    notifyListeners();
  }

  void removeUser() {
    id = null;
    name = null;
    phone_number = null;
    email = null;
    address = null;
    city = null;
    postalCode = null;
    country = null;
    isPhoneVerified = null;
    isEmailVerified = null;
    isAdmin = null;
    token = null;
    refresh = null;
    access = null;
    notifyListeners();
  }

  void setUsername(String name) {
    this.name = name;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    phone_number = phoneNumber;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setAddress(String address) {
    this.address = address;
    notifyListeners();
  }

  void setCity(String city) {
    this.city = city;
    notifyListeners();
  }

  void setPostalCode(String postalCode) {
    this.postalCode = postalCode;
    notifyListeners();
  }

  void setCountry(String country) {
    this.country = country;
    notifyListeners();
  }

  void setIsPhoneVerified(bool isPhoneVerified) {
    this.isPhoneVerified = isPhoneVerified;
    notifyListeners();
  }

  void setIsEmailVerified(bool isEmailVerified) {
    this.isEmailVerified = isEmailVerified;
    notifyListeners();
  }

  void setIsAdmin(bool isAdmin) {
    this.isAdmin = isAdmin;
    notifyListeners();
  }

  void setToken(String token) {
    this.token = token;
    notifyListeners();
  }

  void setRefresh(String refresh) {
    this.refresh = refresh;
    notifyListeners();
  }

  void setAccess(String access) {
    this.access = access;
    notifyListeners();
  }

  UserModel getUser() {
    return this;
  }

  String? getUsername() {
    return name;
  }

  String? getPhoneNumber() {
    return phone_number;
  }

  String? getEmail() {
    return email;
  }

  String? getAddress() {
    return address;
  }

  String? getCity() {
    return city;
  }

  String? getPostalCode() {
    return postalCode;
  }

  String? getCountry() {
    return country;
  }

  bool? getIsPhoneVerified() {
    return isPhoneVerified;
  }

  bool? getIsEmailVerified() {
    return isEmailVerified;
  }

  bool? getIsAdmin() {
    return isAdmin;
  }

  String? getToken() {
    return token;
  }

  String? getRefresh() {
    return refresh;
  }

  String? getAccess() {
    return access;
  }

  UserModel({
    this.id,
    this.name,
    this.phone_number,
    this.email,
    this.address,
    this.city,
    this.postalCode,
    this.country,
    this.isPhoneVerified,
    this.isEmailVerified,
    this.isAdmin,
    this.token,
    this.refresh,
    this.access,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      phone_number: map['phone_number'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      postalCode: map['postalCode'] ?? '',
      country: map['country'] ?? '',
      isPhoneVerified: map['isPhoneVerified'] ?? false,
      isEmailVerified: map['isEmailVerified'] ?? false,
      isAdmin: map['isAdmin'] ?? false,
      token: map['token'] ?? '',
      refresh: map['refresh'] ?? '',
      access: map['access'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone_number': phone_number,
      'email': email,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'country': country,
      'isPhoneVerified': isPhoneVerified,
      'isEmailVerified': isEmailVerified,
      'isAdmin': isAdmin,
      'token': token,
      'refresh': refresh,
      'access': access,
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
