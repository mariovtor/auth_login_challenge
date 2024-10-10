import 'package:desafio_auth_totp/src/core/app_router.dart';
import 'package:desafio_auth_totp/src/core/app_theme.dart';
import 'package:flutter/material.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(context),
      routes: AppRouter.routes,
      initialRoute: AppRouter.initialRoute,
    );
  }
}
