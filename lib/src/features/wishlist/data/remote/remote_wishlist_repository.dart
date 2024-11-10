import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/wishlist/domain/wishlist.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_wishlist_repository.g.dart';

class RemoteWishlistRepository {
  RemoteWishlistRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Future<Wishlist> fetchWishlist(String uid) async {
    final ref = _wishlistRef(uid);
    final snapshot = await ref.get();
    return snapshot.data() ?? const Wishlist();
  }

  Stream<Wishlist> watchWishlist(String uid) {
    final ref = _wishlistRef(uid);
    return ref
        .snapshots()
        .map((snapshot) => snapshot.data() ?? const Wishlist());
  }

  Future<void> setWishlist(String uid, Wishlist wishlist) async {
    final ref = _wishlistRef(uid);
    await ref.set(wishlist);
  }

  DocumentReference<Wishlist> _wishlistRef(UserID uid) =>
      _firestore.doc('/wishlist/$uid').withConverter(
            fromFirestore: (doc, _) => Wishlist.fromMap(doc.data()!),
            toFirestore: (wishlist, _) => wishlist.toMap(),
          );
}

@Riverpod(keepAlive: true)
RemoteWishlistRepository remoteWishlistRepository(
    RemoteWishlistRepositoryRef ref) {
  return RemoteWishlistRepository(FirebaseFirestore.instance);
}
