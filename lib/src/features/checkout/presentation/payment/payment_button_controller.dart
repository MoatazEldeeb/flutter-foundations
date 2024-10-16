import 'dart:async';

import 'package:ecommerce_app/src/features/checkout/application/checkout_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_button_controller.g.dart';

@riverpod
class PaymentButtonController extends _$PaymentButtonController {
  bool mounted = true;
  @override
  FutureOr build() {
    ref.onDispose(() => mounted = false);
  }

  Future<void> pay() async {
    final checkoutService = ref.read(checkoutServiceProvider);
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(checkoutService.placeOrder);

    // * Check if the controller is mounted before setting the state to prevent:
    // * Bad state: Tried to user PaymentButtonController after `dispose` was called
    if (mounted) {
      state = newState;
    }
  }
}
