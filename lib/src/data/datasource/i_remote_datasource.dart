import 'package:desafio_auth_totp/src/domain/models/user_model.dart';

abstract class IRemoteDatasource {
  Future<UserModel> login({
    required String email,
    required String password,
    required String totp,
  });

  Future<String> requestSecret({
    required String email,
    required String password,
    required String code,
  });
}
