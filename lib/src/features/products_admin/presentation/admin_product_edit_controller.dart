import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/products_admin/application/image_upload_service.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:ecommerce_app/src/utils/notifier_mounted.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_product_edit_controller.g.dart';

@riverpod
class AdminProductEditController extends _$AdminProductEditController
    with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
  }

  Future<bool> updateProduct({
    required Product product,
    required String title,
    required String description,
    required String price,
    required String availableQuantity,
  }) async {
    final productsRepository = ref.read(productsRepositoryProvider);
    final priceValue = double.parse(price);
    final availableQuantityValue = int.parse(availableQuantity);
    final updatedProduct = product.copyWith(
      title: title,
      description: description,
      price: priceValue,
      availableQuantity: availableQuantityValue,
    );
    state = const AsyncLoading();
    final value = await AsyncValue.guard(
        () => productsRepository.updateProduct(updatedProduct));
    final success = value.hasError == false;
    if (mounted) {
      state = value;
      if (success) {
        ref.read(goRouterProvider).pop();
      }
    }
    return success;
  }

  Future<void> deleteProduct(Product product) async {
    final imageUploadService = ref.read(imageUploadServiceProvider);
    state = const AsyncLoading();
    final value =
        await AsyncValue.guard(() => imageUploadService.deleteProduct(product));
    final success = value.hasError == false;
    if (mounted) {
      state = value;
      if (success) {
        ref.read(goRouterProvider).pop();
      }
    }
  }
}
