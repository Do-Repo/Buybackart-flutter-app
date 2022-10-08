// ignore_for_file: non_constant_identifier_names

class Banners {
  int id;
  String image;
  String mobile_image;
  String alt_text;

  Banners({
    required this.id,
    required this.image,
    required this.mobile_image,
    required this.alt_text,
  });

  factory Banners.fromMap(Map<String, dynamic> map) {
    return Banners(
      id: map['id']?.toInt() ?? 0,
      image: map['image'] ?? '',
      mobile_image: map['mobile_image'] ?? '',
      alt_text: map['alt_text'] ?? '',
    );
  }
}
