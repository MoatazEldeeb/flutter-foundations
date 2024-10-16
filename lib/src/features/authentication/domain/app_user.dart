import 'package:equatable/equatable.dart';

/// Simple class representing the user UID and email.
typedef UserID = String;

class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    this.email,
    this.emailVerified = false,
  });
  final UserID uid;
  final String? email;
  final bool emailVerified;

  @override
  List<Object?> get props => [uid, email];

  @override
  bool? get stringify => true;
}
