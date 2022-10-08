class Product {
  int id;
  String name;
  String image;

  Product({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
