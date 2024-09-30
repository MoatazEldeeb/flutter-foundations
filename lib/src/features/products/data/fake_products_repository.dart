import 'dart:async';

import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  final List<Product> _products = kTestProducts;

  get fetch => null;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsLists() async* {
    // return Stream.value(_products);
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsLists()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productsListStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductsLists();
});

final productsListFutureProvider = FutureProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductsList();
});

final productProvider = StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  // // This will keep the provider alive
  // final link = ref.keepAlive();
  // // This will dispose the provider after 10 seconds
  // Timer(const Duration(seconds: 10), () {
  //   link.close();
  // });
  final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.watchProduct(id);
});
