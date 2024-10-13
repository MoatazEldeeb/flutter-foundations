import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/features/wishlist/application/wishlist_service.dart';
import 'package:ecommerce_app/src/features/wishlist/presentation/wishlist_screen/wishlist_item.dart';
import 'package:ecommerce_app/src/features/wishlist/presentation/wishlist_screen/wishlist_item_builder.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'.hardcoded),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final wishlistValue = ref.watch(wishlistProvider);
          return AsyncValueWidget(
              value: wishlistValue,
              data: (wishlist) => WishlistItemBuilder(
                  productIDs: wishlist.productIDs,
                  itemBuilder: (_, productId, index) => WishlistItem(
                        productID: productId,
                      )));
        },
      ),
    );
  }
}
