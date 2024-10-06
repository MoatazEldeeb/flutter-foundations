import 'dart:async';

import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  FakeProductsRepository({this.addDelay = true});

  final List<Product> _products = kTestProducts;

  final bool addDelay;

  get fetch => null;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _getProduct(_products, id);
  }

  Future<List<Product>> fetchProductsList() async {
    await delay(addDelay);
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsLists() async* {
    // return Stream.value(_products);
    await delay(addDelay);
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsLists().map((products) => _getProduct(products, id));
  }

  static Product? _getProduct(List<Product> products, String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}

final productsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductsLists();
});

final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductsList();
});

final productProvider =
    StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  // // This will keep the provider alive
  // final link = ref.keepAlive();
  // // This will dispose the provider after 10 seconds
  // Timer(const Duration(seconds: 10), () {
  //   link.close();
  // });
  final productRepository = ref.watch(productsRepositoryProvider);
  return productRepository.watchProduct(id);
});
