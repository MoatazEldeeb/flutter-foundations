import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/wishlist/data/local/local_wishlist_repository.dart';
import 'package:ecommerce_app/src/features/wishlist/data/remote/remote_wishlist_repository.dart';
import 'package:ecommerce_app/src/features/wishlist/domain/mutable_wishlist.dart';
import 'package:ecommerce_app/src/features/wishlist/domain/wishlist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistService {
  WishlistService(
      {required this.fakeAuthRepository,
      required this.localWishlistRepository,
      required this.remoteWishlistRepository});

  final AuthRepository fakeAuthRepository;
  final LocalWishlistRepository localWishlistRepository;
  final RemoteWishlistRepository remoteWishlistRepository;

  Future<Wishlist> _fetchWishlist() {
    final user = fakeAuthRepository.currentUser;
    if (user != null) {
      return remoteWishlistRepository.fetchWishlist(user.uid);
    } else {
      return localWishlistRepository.fetchWishlist();
    }
  }

  Future<void> _setWishlist(Wishlist wishlist) async {
    final user = fakeAuthRepository.currentUser;
    if (user != null) {
      await remoteWishlistRepository.setWishlist(user.uid, wishlist);
    } else {
      await localWishlistRepository.setWishlist(wishlist);
    }
  }

  Future<void> addProductId(ProductID productId) async {
    final wishlist = await _fetchWishlist();
    final updated = wishlist.addItems([productId]);
    await _setWishlist(updated);
  }

  Future<void> removeProductById(ProductID productId) async {
    final wishlist = await _fetchWishlist();
    final updated = wishlist.removeItemById(productId);
    await _setWishlist(updated);
  }
}

final wishlistServiceProvider = Provider<WishlistService>((ref) {
  return WishlistService(
      fakeAuthRepository: ref.watch(authRepositoryProvider),
      localWishlistRepository: ref.watch(localWishlistRepositoryProvider),
      remoteWishlistRepository: ref.watch(remoteWishlistRepositoryProvider));
});

final wishlistProvider = StreamProvider<Wishlist>((ref) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(remoteWishlistRepositoryProvider).watchWishlist(user.uid);
  } else {
    return ref.watch(localWishlistRepositoryProvider).watchWishlist();
  }
});

final wishlistItemsCountProvider = Provider<int>((ref) {
  final wishlist = ref.watch(wishlistProvider).value;
  if (wishlist != null) {
    return wishlist.productIDs.length;
  } else {
    return 0;
  }
});

final alreadyAddedToWishlistProvider =
    Provider.family<bool, ProductID>((ref, productId) {
  final wishlist = ref.watch(wishlistProvider).value;
  if (wishlist != null) {
    for (final id in wishlist.productIDs) {
      if (id == productId) {
        return true;
      }
    }
  } else {
    return false;
  }
  return false;
});
