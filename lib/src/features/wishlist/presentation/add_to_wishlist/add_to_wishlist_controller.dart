import 'dart:async';

import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wishlist/application/wishlist_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_to_wishlist_controller.g.dart';

@riverpod
class AddToWishlistController extends _$AddToWishlistController {
  @override
  FutureOr build() {
    // nothing to do
  }

  Future<void> addProductToWishlist(ProductID productId) async {
    final wishlistService = ref.read(wishlistServiceProvider);
    state = const AsyncLoading();
    final value =
        await AsyncValue.guard(() => wishlistService.addProductId(productId));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(null);
    }
  }
}
