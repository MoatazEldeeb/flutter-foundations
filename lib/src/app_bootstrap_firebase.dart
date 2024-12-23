import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/app_bootstrap.dart';
import 'package:ecommerce_app/src/features/cart/data/local/sembast_cart_repository.dart';
import 'package:ecommerce_app/src/features/wishlist/data/local/local_wishlist_repository.dart';
import 'package:ecommerce_app/src/features/wishlist/data/local/sembast_wishlist_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/src/exceptions/async_error_logger.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/fake_remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/orders/data/fake_orders_repository.dart';
import 'package:ecommerce_app/src/features/orders/data/orders_repository.dart';
import 'package:ecommerce_app/src/features/reviews/data/fake_reviews_repository.dart';
import 'package:ecommerce_app/src/features/reviews/data/reviews_repository.dart';

extension AppBootstrapFirebase on AppBootstrap {
  /// Creates the top-level [ProviderContainer] by overriding providers with fake
  /// repositories only. This is useful for testing purposes and for running the
  /// app with a "fake" backend.
  ///
  /// Note: all repositories needed by the app can be accessed via providers.
  /// Some of these providers throw an [UnimplementedError] by default.
  ///
  /// Example:
  /// ```dart
  /// @Riverpod(keepAlive: true)
  /// LocalCartRepository localCartRepository(LocalCartRepositoryRef ref) {
  ///   throw UnimplementedError();
  /// }
  /// ```
  ///
  /// As a result, this method does two things:
  /// - create and configure the repositories as desired
  /// - override the default implementations with a list of "overrides"

  Future<ProviderContainer> createFirebaseProviderContainer(
      {bool addDelay = true}) async {
    // TODO: Replace with Firebase repositories
    final reviewsRepository = FakeReviewsRepository(addDelay: addDelay);
    final localCartRepository = await SembastCartRepository.makeDefault();
    // * set delay to false to make it easier to add/remove items
    final ordersRepository = FakeOrdersRepository(addDelay: addDelay);
    final localWishlistRepository =
        await SembastWishlistRepository.makeDefault();

    return ProviderContainer(
      overrides: [
        // repositories
        reviewsRepositoryProvider.overrideWithValue(reviewsRepository),
        ordersRepositoryProvider.overrideWithValue(ordersRepository),
        localCartRepositoryProvider.overrideWithValue(localCartRepository),
        localWishlistRepositoryProvider
            .overrideWithValue(localWishlistRepository),
      ],
      observers: [AsyncErrorLogger()],
    );
  }

  Future<void> setupEmulators() async {
    await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
    await FirebaseStorage.instance.useStorageEmulator('127.0.0.1', 9199);
  }
}
