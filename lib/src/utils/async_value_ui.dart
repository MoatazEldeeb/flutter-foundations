import 'package:ecommerce_app/src/common_widgets/alert_dialogs.dart';
import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = _errorMessage(error);
      showExceptionAlertDialog(
          context: context, title: 'Error'.hardcoded, exception: message);
    }
  }

  String _errorMessage(Object? error) {
    if (error is FirebaseAuthException) {
      return error.message ?? error.toString();
    } else if (error is AppException) {
      return error.message;
    } else {
      return error.toString();
    }
  }
}
