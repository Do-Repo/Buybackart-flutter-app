class Brands {
  int id;
  String image;

  Brands({
    required this.id,
    required this.image,
  });

  factory Brands.fromMap(Map<String, dynamic> map) {
    return Brands(
      id: map['id']?.toInt() ?? 0,
      image: map['image'] ?? '',
    );
  }
}
