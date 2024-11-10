/// Simple class representing the user UID and email.
typedef UserID = String;

class AppUser {
  const AppUser({
    required this.uid,
    this.email,
    this.emailVerified = false,
  });
  final UserID uid;
  final String? email;
  final bool emailVerified;

  Future<void> sendEmailVerification() async {
    // no-op - implemented by subclasses
  }

  Future<bool> isAdmin() {
    return Future.value(false);
  }

  Future<void> forceRefreshIdToken() async {
    // no-op - implemented by subclasses
  }

  @override
  String toString() =>
      'AppUser(uid: $uid, email: $email, emailVerified: $emailVerified)';

  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.emailVerified == emailVerified;
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ emailVerified.hashCode;
}
