import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/shopping_cart_icon.dart';
import 'package:ecommerce_app/src/features/wishlist/application/wishlist_service.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WishlistIcon extends ConsumerWidget {
  const WishlistIcon({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistItemCount = ref.watch(wishlistItemsCountProvider);
    return Stack(
      children: [
        Center(
            child: IconButton(
                onPressed: () => context.pushNamed(AppRoute.wishlist.name),
                icon: const Icon(Icons.shopping_basket))),
        if (wishlistItemCount > 0)
          Positioned(
              top: Sizes.p4,
              right: Sizes.p4,
              child: IconBadge(
                itemsCount: wishlistItemCount,
              )),
      ],
    );
  }
}
