import 'package:ecommerce_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_center.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/constants/breakpoints.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';

class WishlistItemBuilder extends StatelessWidget {
  const WishlistItemBuilder(
      {super.key, required this.productIDs, required this.itemBuilder});
  final List<ProductID> productIDs;
  final Widget Function(BuildContext, ProductID, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (productIDs.isEmpty) {
      return EmptyPlaceholderWidget(
        message: 'Your wishlist is empty'.hardcoded,
      );
    }
    final screenWidth = MediaQuery.of(context).size.width;
    // * on wide layouts, show a list of items on the left and the checkout
    // * button on the right
    if (screenWidth >= Breakpoint.tablet) {
      return ResponsiveCenter(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Row(
          children: [
            Flexible(
              // use 3 flex units for the list of items
              flex: 3,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
                itemBuilder: (context, index) {
                  final item = productIDs[index];
                  return itemBuilder(context, item, index);
                },
                itemCount: productIDs.length,
              ),
            ),
          ],
        ),
      );
    } else {
      // * on narrow layouts, show a [Column] with a scrollable list of items
      // * and a pinned box at the bottom with the checkout button
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(Sizes.p16),
              itemBuilder: (context, index) {
                final item = productIDs[index];
                return itemBuilder(context, item, index);
              },
              itemCount: productIDs.length,
            ),
          ),
        ],
      );
    }
  }
}
