import 'package:desafio_auth_totp/src/core/locator.dart';
import 'package:desafio_auth_totp/src/login_app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Locator().initDependencies();
  runApp(const LoginApp());
}
