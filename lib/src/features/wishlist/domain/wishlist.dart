import 'dart:convert';

import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter/foundation.dart';

class Wishlist {
  const Wishlist([this.productIDs = const []]);

  final List<ProductID> productIDs;

  Map<String, dynamic> toMap() {
    return {
      'productIDs': productIDs,
    };
  }

  factory Wishlist.fromMap(Map<String, dynamic> map) {
    return Wishlist(
      List<ProductID>.from(map['productIDs']!),
    );
  }

  String toJson() => json.encode(toMap());

  factory Wishlist.fromJson(String source) =>
      Wishlist.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(productIDs: $productIDs)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Wishlist && listEquals(other.productIDs, productIDs);
  }

  @override
  int get hashCode => productIDs.hashCode;
}
