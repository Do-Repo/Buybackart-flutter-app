import 'dart:convert';

// ignore_for_file: non_constant_identifier_names

class ProductDetails {
  int id;
  String name;
  String product_category;
  String image;
  List<Variants> variants;
  List<Accessories> attachedaccessory;

  ProductDetails({
    required this.id,
    required this.name,
    required this.product_category,
    required this.image,
    required this.variants,
    required this.attachedaccessory,
  });

  factory ProductDetails.fromMap(Map<String, dynamic> map) {
    return ProductDetails(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      product_category: map['product_category'] ?? '',
      image: map['image'] ?? '',
      variants:
          List<Variants>.from(map['variants']?.map((x) => Variants.fromMap(x))),
      attachedaccessory: List<Accessories>.from(
          map['attachedaccessory']?.map((x) => Accessories.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'product_category': product_category,
      'image': image,
      'variants': variants.map((x) => x.toMap()).toList(),
      'attachedaccessory': attachedaccessory.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ProductDetails.fromJson(String source) =>
      ProductDetails.fromMap(json.decode(source));
}

class Accessories {
  int id;
  String parent;
  String image;
  String product;
  int weightage;

  Accessories({
    required this.id,
    required this.parent,
    required this.image,
    required this.product,
    required this.weightage,
  });

  factory Accessories.fromMap(Map<String, dynamic> map) {
    return Accessories(
      id: map['id']?.toInt() ?? 0,
      parent: map['parent'] ?? '',
      image: map['image'] ?? '',
      product: map['product'] ?? '',
      weightage: map['weightage']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'parent': parent,
      'image': image,
      'product': product,
      'weightage': weightage,
    };
  }

  String toJson() => json.encode(toMap());

  factory Accessories.fromJson(String source) =>
      Accessories.fromMap(json.decode(source));
}

class Variants {
  int id;
  String variant;
  String product;
  int market_retail_price;

  Variants({
    required this.id,
    required this.variant,
    required this.product,
    required this.market_retail_price,
  });

  factory Variants.fromMap(Map<String, dynamic> map) {
    return Variants(
      id: map['id']?.toInt() ?? 0,
      variant: map['variant'] ?? '',
      product: map['product'] ?? '',
      market_retail_price: map['market_retail_price']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'variant': variant,
      'product': product,
      'market_retail_price': market_retail_price,
    };
  }

  String toJson() => json.encode(toMap());

  factory Variants.fromJson(String source) =>
      Variants.fromMap(json.decode(source));
}
