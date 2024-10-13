import 'dart:async';

import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wishlist/application/wishlist_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_screen_controller.g.dart';

@riverpod
class WishlistScreenController extends _$WishlistScreenController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> removeProductById(ProductID productId) async {
    final wishlistService = ref.read(wishlistServiceProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => wishlistService.removeProductById(productId));
  }
}
