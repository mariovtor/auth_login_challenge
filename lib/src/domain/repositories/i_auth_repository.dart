import 'package:desafio_auth_totp/src/domain/models/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> login({
    required String email,
    required String password,
    required String secret,
  });

  Future<bool> isValidCredentials({
    required String email,
    required String password,
  });

  Future<String> generateTotp(String secret);
  Future<String> requestSecret({
    required String email,
    required String password,
    required String code,
  });
}
