import 'package:desafio_auth_totp/src/features/auth/login/login_page.dart';
import 'package:desafio_auth_totp/src/features/auth/secret/secret_verify_page.dart';
import 'package:desafio_auth_totp/src/features/home/home_page.dart';

class AppRouter {
  AppRouter._();
  static const initialRoute = LoginPage.pageName;

  static final routes = {
    LoginPage.pageName: (context) => const LoginPage(),
    SecretVerifyPage.pageName: (context) => const SecretVerifyPage(),
    HomePage.pageName: (context) => const HomePage(),
  };
}
