import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/checkout/application/checkout_service.dart';
import 'package:ecommerce_app/src/features/orders/data/fake_orders_repository.dart';
import 'package:ecommerce_app/src/features/orders/domain/order.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';

class FakeCheckoutService implements CheckoutService {
  // * To make writing unit tests easier, here we pass all dependencies as
  // * arguments rather than using a Ref
  const FakeCheckoutService({
    required this.authRepository,
    required this.remoteCartRepository,
    required this.fakeOrdersRepository,
    required this.fakeProducsRepository,
    required this.currentDateBuilder,
  });
  final AuthRepository authRepository;
  final RemoteCartRepository remoteCartRepository;
  final FakeOrdersRepository fakeOrdersRepository;
  final FakeProductsRepository fakeProducsRepository;
  final DateTime Function() currentDateBuilder;

  @override
  Future<void> placeOrder() async {
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
    await fakeOrdersRepository.addOrder(uid, order);
    await remoteCartRepository.setCart(uid, const Cart());
  }

  double _totalPrice(Cart cart) {
    // final totalPrice = ref.read(cartTotalProvider);
    if (cart.items.isEmpty) {
      return 0.0;
    }
    return cart.items.entries
        .map((entry) =>
            entry.value * fakeProducsRepository.getProduct(entry.key)!.price)
        .reduce((value, element) => value + element);
  }
}
