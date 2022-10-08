import 'dart:convert';

import 'package:upwork_app/models/product_details.dart';

class SearchModel {
  int page;
  int pages;
  List<ProductDetails> products;

  SearchModel({
    required this.page,
    required this.pages,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pages': pages,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      page: map['page']?.toInt() ?? 0,
      pages: map['pages']?.toInt() ?? 0,
      products: List<ProductDetails>.from(
          map['products']?.map((x) => ProductDetails.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchModel.fromJson(String source) =>
      SearchModel.fromMap(json.decode(source));
}
