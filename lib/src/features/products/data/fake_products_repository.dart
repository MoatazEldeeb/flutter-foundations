import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

class FakeProductsRepository {
  static FakeProductsRepository instance = FakeProductsRepository._();

  FakeProductsRepository._();

  final List<Product> _products = kTestProducts;

  get fetch => null;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() {
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsLists() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsLists()
    .map((products)=> products.firstWhere((product)=>product.id==id));
  }
}
