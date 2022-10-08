import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class Order {
  int id;
  String user;
  String email;
  String phone_number;
  String product;
  String prod_category;
  int prod_id;
  String prod_image;
  String variant;
  int final_price;
  String status;
  String timestamp;
  String updated;

  Order({
    required this.id,
    required this.user,
    required this.email,
    required this.phone_number,
    required this.product,
    required this.prod_category,
    required this.prod_id,
    required this.prod_image,
    required this.variant,
    required this.final_price,
    required this.status,
    required this.timestamp,
    required this.updated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'email': email,
      'phone_number': phone_number,
      'product': product,
      'prod_category': prod_category,
      'prod_id': prod_id,
      'prod_image': prod_image,
      'variant': variant,
      'final_price': final_price,
      'status': status,
      'timestamp': timestamp,
      'updated': updated,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id']?.toInt() ?? 0,
      user: map['user'] ?? '',
      email: map['email'] ?? '',
      phone_number: map['phone_number'] ?? '',
      product: map['product'] ?? '',
      prod_category: map['prod_category'] ?? '',
      prod_id: map['prod_id']?.toInt() ?? 0,
      prod_image: map['prod_image'] ?? '',
      variant: map['variant'] ?? '',
      final_price: map['final_price']?.toInt() ?? 0,
      status: map['status'] ?? '',
      timestamp: map['timestamp'] ?? '',
      updated: map['updated'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}

class FinalizedOrder {
  int id;
  String user;
  String email;
  String phone_number;
  String assigned_to;
  String assigned_executive_number;
  String product;
  String prod_image;
  String variant;
  int market_retail_price;
  int auto_evaluated_price;
  int final_price;
  String used_refferal_code;
  String pick_up_location;
  String state;
  String city;
  String status;
  String schedualed_date;
  String time_slot;
  String preffered_payment_option;
  String timestamp;
  String updated;
  String warranty;

  FinalizedOrder({
    required this.id,
    required this.user,
    required this.email,
    required this.phone_number,
    required this.assigned_to,
    required this.assigned_executive_number,
    required this.product,
    required this.prod_image,
    required this.variant,
    required this.market_retail_price,
    required this.auto_evaluated_price,
    required this.final_price,
    required this.used_refferal_code,
    required this.pick_up_location,
    required this.state,
    required this.city,
    required this.status,
    required this.schedualed_date,
    required this.time_slot,
    required this.preffered_payment_option,
    required this.timestamp,
    required this.updated,
    required this.warranty,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'email': email,
      'phone_number': phone_number,
      'assigned_to': assigned_to,
      'assigned_executive_number': assigned_executive_number,
      'product': product,
      'prod_image': prod_image,
      'variant': variant,
      'market_retail_price': market_retail_price,
      'auto_evaluated_price': auto_evaluated_price,
      'final_price': final_price,
      'used_refferal_code': used_refferal_code,
      'pick_up_location': pick_up_location,
      'state': state,
      'city': city,
      'status': status,
      'schedualed_date': schedualed_date,
      'time_slot': time_slot,
      'preffered_payment_option': preffered_payment_option,
      'timestamp': timestamp,
      'updated': updated,
      'warranty': warranty,
    };
  }

  factory FinalizedOrder.fromMap(Map<String, dynamic> map) {
    return FinalizedOrder(
      id: map['id']?.toInt() ?? 0,
      user: map['user'] ?? '',
      email: map['email'] ?? '',
      phone_number: map['phone_number'] ?? '',
      assigned_to: map['assigned_to'] ?? '',
      assigned_executive_number: map['assigned_executive_number'] ?? '',
      product: map['product'] ?? '',
      prod_image: map['prod_image'] ?? '',
      variant: map['variant'] ?? '',
      market_retail_price: map['market_retail_price']?.toInt() ?? 0,
      auto_evaluated_price: map['auto_evaluated_price']?.toInt() ?? 0,
      final_price: map['final_price']?.toInt() ?? 0,
      used_refferal_code: map['used_refferal_code'] ?? '',
      pick_up_location: map['pick_up_location'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      status: map['status'] ?? '',
      schedualed_date: map['schedualed_date'] ?? '',
      time_slot: map['time_slot'] ?? '',
      preffered_payment_option: map['preffered_payment_option'] ?? '',
      timestamp: map['timestamp'] ?? '',
      updated: map['updated'] ?? '',
      warranty: map['warranty'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FinalizedOrder.fromJson(String source) =>
      FinalizedOrder.fromMap(json.decode(source));
}

class MiniOrder {
  int id;
  String product;
  String status;
  String timestamp;

  MiniOrder({
    required this.id,
    required this.product,
    required this.status,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product,
      'status': status,
      'timestamp': timestamp,
    };
  }

  factory MiniOrder.fromMap(Map<String, dynamic> map) {
    return MiniOrder(
      id: map['id']?.toInt() ?? 0,
      product: map['product'] ?? '',
      status: map['status'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MiniOrder.fromJson(String source) =>
      MiniOrder.fromMap(json.decode(source));
}
