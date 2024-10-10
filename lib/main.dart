import 'package:desafio_auth_totp/src/core/locator.dart';
import 'package:desafio_auth_totp/src/login_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locator().initDependencies();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const LoginApp());
}
