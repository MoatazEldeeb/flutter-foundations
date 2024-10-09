import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wishlist/application/wishlist_service.dart';
import 'package:ecommerce_app/src/features/wishlist/presentation/add_to_wishlist/add_to_wishlist_controller.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddToWishlist extends ConsumerWidget {
  const AddToWishlist({super.key, required this.product});

  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(addToWishlistControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));

    final state = ref.watch(addToWishlistControllerProvider);
    final alreadyAdded = ref.watch(alreadyAddedToWishlistProvider(product.id));
    return PrimaryButton(
      isLoading: state.isLoading,
      onPressed: alreadyAdded
          ? null
          : () => ref
              .read(addToWishlistControllerProvider.notifier)
              .addProductToWishlist(product.id),
      text: alreadyAdded
          ? 'Added to wishlist'.hardcoded
          : 'Add to Wishlist'.hardcoded,
    );
  }
}
