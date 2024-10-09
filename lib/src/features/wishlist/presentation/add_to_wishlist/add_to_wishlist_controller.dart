import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wishlist/application/wishlist_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToWishlistController extends StateNotifier<AsyncValue<void>> {
  AddToWishlistController({required this.wishlistService})
      : super(const AsyncData(null));

  final WishlistService wishlistService;

  Future<void> addProductToWishlist(ProductID productId) async {
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

final addToWishlistControllerProvider =
    StateNotifierProvider<AddToWishlistController, AsyncValue<void>>((ref) {
  return AddToWishlistController(
      wishlistService: ref.watch(wishlistServiceProvider));
});
