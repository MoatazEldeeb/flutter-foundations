import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wishlist/domain/wishlist.dart';

extension MutableWishlist on Wishlist {
  Wishlist addItems(List<ProductID> productIdsToAdd) {
    final copy = List<ProductID>.from(productIDs);
    for (var productId in productIdsToAdd) {
      if (!copy.contains(productId)) {
        copy.add(productId);
      }
    }
    return Wishlist(copy);
  }

  /// if an item with the given productId is found, remove it
  Wishlist removeItemById(ProductID productId) {
    final copy = List<ProductID>.from(productIDs);
    copy.remove(productId);
    return Wishlist(copy);
  }
}
