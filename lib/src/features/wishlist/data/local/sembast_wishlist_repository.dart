import 'package:ecommerce_app/src/features/wishlist/data/local/local_wishlist_repository.dart';
import 'package:ecommerce_app/src/features/wishlist/domain/wishlist.dart';
import 'package:ecommerce_app/src/utils/database.dart';
import 'package:sembast/sembast.dart';

class SembastWishlistRepository implements LocalWishlistRepository {
  SembastWishlistRepository(this.db);

  final Database db;
  final store = StoreRef.main();

  static Future<SembastWishlistRepository> makeDefault() async {
    return SembastWishlistRepository(await createDatabase('default.db'));
  }

  static const wishlistItemsKey = 'wishlistItems';

  @override
  Future<Wishlist> fetchWishlist() async {
    final wishlistJson =
        await store.record(wishlistItemsKey).get(db) as String?;
    if (wishlistJson != null) {
      return Wishlist.fromJson(wishlistJson);
    } else {
      return const Wishlist();
    }
  }

  @override
  Future<void> setWishlist(Wishlist wishlist) {
    return store.record(wishlistItemsKey).put(db, wishlist.toJson());
  }

  @override
  Stream<Wishlist> watchWishlist() {
    final record = store.record(wishlistItemsKey);
    return record.onSnapshot(db).map((snapshot) {
      if (snapshot != null) {
        return Wishlist.fromJson(snapshot.value as String);
      } else {
        return const Wishlist();
      }
    });
  }
}
