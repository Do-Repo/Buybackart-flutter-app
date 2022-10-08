// ignore_for_file: non_constant_identifier_names

class ExcitingOffers {
  int id;
  int parent;
  String name;
  String image;
  String first_variant;
  int price_for_first_variant;
  String second_variant;
  int price_for_second_variant;
  ExcitingOffers({
    required this.id,
    required this.parent,
    required this.name,
    required this.image,
    required this.first_variant,
    required this.price_for_first_variant,
    required this.second_variant,
    required this.price_for_second_variant,
  });

  factory ExcitingOffers.fromMap(Map<String, dynamic> map) {
    return ExcitingOffers(
      id: map['id']?.toInt() ?? 0,
      parent: map['parent']?.toInt() ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      first_variant: map['first_variant'] ?? '',
      price_for_first_variant: map['price_for_first_variant']?.toInt() ?? 0,
      second_variant: map['second_variant'] ?? '',
      price_for_second_variant: map['price_for_second_variant']?.toInt() ?? 0,
    );
  }
}
