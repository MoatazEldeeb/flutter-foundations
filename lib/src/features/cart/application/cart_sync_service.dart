import 'dart:math';

import 'package:ecommerce_app/src/exceptions/error_logger.dart';
import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/cart/domain/mutable_cart.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_sync_service.g.dart';

class CartSyncService {
  CartSyncService(this.ref) {
    _init();
  }
  final Ref ref;

  void _init() {
    ref.listen<AsyncValue<AppUser?>>(
      authStateChangesProvider,
      (previous, next) {
        final previousUser = previous?.value;
        final user = next.value;
        if (previousUser == null && user != null) {
          _moveItemsToRemoteCart(user.uid);
        }
      },
    );
  }

  Future<void> _moveItemsToRemoteCart(String uid) async {
    try {
      final localCartRepository = ref.watch(localCartRepositoryProvider);
      final localCart = await localCartRepository.fetchCart();
      if (localCart.items.isNotEmpty) {
        final remoteCartRepository = ref.watch(remoteCartRepositoryProvider);
        final remoteCart = await remoteCartRepository.fetchCart(uid);
        final localItemsToAdd =
            await _getLocalItemsToAdd(localCart, remoteCart);
        final updatedRemoteCart = remoteCart.addItems(localItemsToAdd);
        await remoteCartRepository.setCart(uid, updatedRemoteCart);
        await localCartRepository.setCart(const Cart());
      }
    } catch (e, st) {
      ref.read(errorLoggerProvider).logError(e, st);
    }
  }

  Future<List<Item>> _getLocalItemsToAdd(
      Cart localCart, Cart remoteCart) async {
    final productsRepository = ref.read(productsRepositoryProvider);
    final products = await productsRepository.fetchProductsList();
    final localItemsToAdd = <Item>[];

    for (final localItem in localCart.items.entries) {
      final productId = localItem.key;
      final localQuantity = localItem.value;

      final remoteQuantity = remoteCart.items[productId] ?? 0;
      final product = products.firstWhere((product) => product.id == productId);

      final cappedLocalQuantity =
          min(localQuantity, product.availableQuantity - remoteQuantity);

      if (cappedLocalQuantity > 0) {
        localItemsToAdd
            .add(Item(productId: productId, quantity: cappedLocalQuantity));
      }
    }
    return localItemsToAdd;
  }
}

@Riverpod(keepAlive: true)
CartSyncService cartSyncService(CartSyncServiceRef ref) {
  return CartSyncService(ref);
}
