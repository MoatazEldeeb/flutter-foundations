import 'dart:math';

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/cart/domain/mutable_cart.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartService {
  CartService(
      {required this.fakeAuthRepository,
      required this.localCartRepository,
      required this.remoteCartRepository});

  final FakeAuthRepository fakeAuthRepository;
  final LocalCartRepository localCartRepository;
  final RemoteCartRepository remoteCartRepository;

  /// fetch the cart to the local or remote repositoy
  /// depending on the user auth state
  Future<Cart> _fetchCart() {
    final user = fakeAuthRepository.currentUser;
    if (user != null) {
      return remoteCartRepository.fetchCart(user.uid);
    } else {
      return localCartRepository.fetchCart();
    }
  }

  /// save the cart to the local or remote repositoy
  /// depending on the user auth state
  Future<void> _setCart(Cart cart) async {
    final user = fakeAuthRepository.currentUser;

    if (user != null) {
      await remoteCartRepository.setCart(user.uid, cart);
    } else {
      await localCartRepository.setCart(cart);
    }
  }

  /// sets an item in the local or remote cart depending on the auth state
  Future<void> setItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.setItem(item);
    await _setCart(updated);
  }

  /// adds an item in the local or remote cart depending on the auth state
  Future<void> addItem(Item item) async {
    final cart = await _fetchCart();
    final updated = cart.addItem(item);
    await _setCart(updated);
  }

  /// removes an item in the local or remote cart depending on the auth state
  Future<void> removeItemByID(ProductID id) async {
    final cart = await _fetchCart();
    final updated = cart.removeItemById(id);
    await _setCart(updated);
  }
}

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService(
      fakeAuthRepository: ref.watch(authRepositoryProvider),
      localCartRepository: ref.watch(localCartRepositoryProvider),
      remoteCartRepository: ref.watch(remoteCartRepositoryProvider));
});

final cartProvider = StreamProvider<Cart>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(remoteCartRepositoryProvider).watchCart(user.uid);
  } else {
    return ref.watch(localCartRepositoryProvider).watchCart();
  }
});

final cartItemsCountProvider = Provider<int>((ref) {
  return ref
      .watch(cartProvider)
      .maybeMap(data: (cart) => cart.value.items.length, orElse: () => 0);
});

final cartTotalProvider = Provider.autoDispose<double>((ref) {
  final cart = ref.watch(cartProvider).value ?? const Cart();
  final productsList = ref.watch(productsListStreamProvider).value ?? const [];

  if (cart.items.isNotEmpty && productsList.isNotEmpty) {
    var total = 0.0;
    for (final item in cart.items.entries) {
      final product =
          productsList.firstWhere((product) => product.id == item.key);

      total += product.price * item.value;
    }
    return total;
  } else {
    return 0.0;
  }
});

final itemAvailableQuantityProvider =
    Provider.family<int, Product>((ref, product) {
  final cart = ref.watch(cartProvider).value;
  if (cart != null) {
    final quantity = cart.items[product.id] ?? 0;
    return max(0, product.availableQuantity - quantity);
  } else {
    return product.availableQuantity;
  }
});
