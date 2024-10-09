import 'package:ecommerce_app/src/features/wishlist/data/remote/remote_wishlist_repository.dart';
import 'package:ecommerce_app/src/features/wishlist/domain/wishlist.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';

class FakeRemoteWishlistRepository implements RemoteWishlistRepository {
  FakeRemoteWishlistRepository({this.addDelay = true});
  final bool addDelay;

  final _wishlists = InMemoryStore<Map<String, Wishlist>>({});

  @override
  Future<Wishlist> fetchWishlist(String uid) {
    return Future.value(_wishlists.value[uid] ?? const Wishlist());
  }

  @override
  Future<void> setWishlist(String uid, Wishlist wishlist) async {
    await delay(addDelay);
    final wishlists = _wishlists.value;
    wishlists[uid] = wishlist;
    _wishlists.value = wishlists;
  }

  @override
  Stream<Wishlist> watchWishlist(String uid) {
    return _wishlists.stream
        .map((wishlistData) => wishlistData[uid] ?? const Wishlist());
  }
}
