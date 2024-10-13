import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/orders/data/fake_orders_repository.dart';
import 'package:ecommerce_app/src/features/orders/domain/order.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/utils/current_date_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fake_checkout_service.g.dart';

class FakeCheckoutService {
  FakeCheckoutService({required this.ref});
  final Ref ref;

  Future<void> placeOrder() async {
    final authRepository = ref.read(authRepositoryProvider);
    final remoteCartRepository = ref.read(remoteCartRepositoryProvider);
    final ordersRepository = ref.read(ordersRepositoryProvider);
    final currentDateBuilder = ref.read(currentDateBuilderProvider);

    final uid = authRepository.currentUser!.uid;
    final cart = await remoteCartRepository.fetchCart(uid);
    final total = _totalPrice(cart);
    final orderDate = currentDateBuilder();
    final orderId = orderDate.toIso8601String();
    final order = Order(
        id: orderId,
        userId: uid,
        items: cart.items,
        orderStatus: OrderStatus.confirmed,
        orderDate: orderDate,
        total: total);
    await ordersRepository.addOrder(uid, order);
    await remoteCartRepository.setCart(uid, const Cart());
  }

  double _totalPrice(Cart cart) {
    // final totalPrice = ref.read(cartTotalProvider);
    if (cart.items.isEmpty) {
      return 0.0;
    }
    final productsRepository = ref.read(productsRepositoryProvider);
    return cart.items.entries
        .map((entry) =>
            entry.value * productsRepository.getProduct(entry.key)!.price)
        .reduce((value, element) => value + element);
  }
}

@riverpod
FakeCheckoutService checkoutService(CheckoutServiceRef ref) {
  return FakeCheckoutService(ref: ref);
}
