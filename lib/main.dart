import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/src/app_bootstrap_firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/app_bootstrap.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // turn off the # in the URLs on the web
  usePathUrlStrategy();

  final appBootstrap = AppBootstrap();

  final container = await appBootstrap.createFirebaseProviderContainer();
  final root = appBootstrap.createRootWidget(container: container);
  runApp(root);
}
