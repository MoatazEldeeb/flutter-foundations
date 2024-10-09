import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wishlist/application/wishlist_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistScreenController extends StateNotifier<AsyncValue<void>> {
  WishlistScreenController({required this.wishlistService})
      : super(const AsyncData(null));

  final WishlistService wishlistService;

  Future<void> removeProductById(ProductID productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => wishlistService.removeProductById(productId));
  }
}

final wishlistScreenControllerProvider =
    StateNotifierProvider<WishlistScreenController, AsyncValue<void>>((ref) {
  return WishlistScreenController(
      wishlistService: ref.watch(wishlistServiceProvider));
});
