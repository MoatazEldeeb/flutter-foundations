import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/wishlist/data/local/local_wishlist_repository.dart';
import 'package:ecommerce_app/src/features/wishlist/data/remote/remote_wishlist_repository.dart';
import 'package:ecommerce_app/src/features/wishlist/domain/mutable_wishlist.dart';
import 'package:ecommerce_app/src/features/wishlist/domain/wishlist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistSyncService {
  WishlistSyncService({required this.ref}) {
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
          _moveItemsToRemoteWishlist(user.uid);
        }
      },
    );
  }

  Future<void> _moveItemsToRemoteWishlist(String uid) async {
    try {
      final localWishlistRepository =
          ref.watch(localWishlistRepositoryProvider);
      final localWishlist = await localWishlistRepository.fetchWishlist();
      if (localWishlist.productIDs.isNotEmpty) {
        final remoteWishlistRepository =
            ref.watch(remoteWishlistRepositoryProvider);
        final remoteCart = await remoteWishlistRepository.fetchWishlist(uid);
        final localItemsToAdd = localWishlist.productIDs;
        final updatedRemoteCart = remoteCart.addItems(localItemsToAdd);
        await remoteWishlistRepository.setWishlist(uid, updatedRemoteCart);
        await localWishlistRepository.setWishlist(const Wishlist());
      }
    } catch (e) {
      // TODO: Handle error or rethrow
    }
  }
}

final wishlistSyncServiceProvider = Provider<WishlistSyncService>((ref) {
  return WishlistSyncService(ref: ref);
});
