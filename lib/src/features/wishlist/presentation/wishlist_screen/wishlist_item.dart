import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/common_widgets/custom_image.dart';
import 'package:ecommerce_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_two_column_layout.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wishlist/presentation/wishlist_screen/wishlist_screen_controller.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class WishlistItem extends ConsumerWidget {
  const WishlistItem({super.key, required this.productID});
  final ProductID productID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productValue = ref.watch(productProvider(productID));
    return AsyncValueWidget<Product?>(
      value: productValue,
      data: (product) => Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: WishlistItemContents(product: product!),
          ),
        ),
      ),
    );
  }
}

class WishlistItemContents extends ConsumerWidget {
  const WishlistItemContents({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(wishlistScreenControllerProvider);
    final priceFormatted = NumberFormat.simpleCurrency().format(product.price);

    return ResponsiveTwoColumnLayout(
      startFlex: 1,
      endFlex: 2,
      breakpoint: 320,
      startContent: CustomImage(imageUrl: product.imageUrl),
      spacing: Sizes.p24,
      endContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.title, style: Theme.of(context).textTheme.headlineSmall),
          gapH24,
          Text(priceFormatted,
              style: Theme.of(context).textTheme.headlineSmall),
          gapH24,
          Row(
            children: [
              const Spacer(),
              state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : IconButton(
                      icon: Icon(Icons.delete, color: Colors.red[700]),
                      onPressed: state.isLoading
                          ? null
                          : () => ref
                              .read(wishlistScreenControllerProvider.notifier)
                              .removeProductById(product.id),
                    )
            ],
          )
        ],
      ),
    );
  }
}
