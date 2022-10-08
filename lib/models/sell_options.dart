import 'dart:convert';

class SellOptions {
  int id;
  String title;
  String image;

  SellOptions({
    required this.id,
    required this.title,
    required this.image,
  });

  factory SellOptions.fromMap(Map<String, dynamic> map) {
    return SellOptions(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      image: map['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

  String toJson() => json.encode(toMap());

  factory SellOptions.fromJson(String source) =>
      SellOptions.fromMap(json.decode(source));
}
