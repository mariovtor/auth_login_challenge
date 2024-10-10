import 'package:desafio_auth_totp/src/core/custom_exception.dart';
import 'package:desafio_auth_totp/src/data/datasource/i_remote_datasource.dart';
import 'package:desafio_auth_totp/src/domain/models/user_model.dart';
import 'package:desafio_auth_totp/src/domain/repositories/i_auth_repository.dart';
import 'package:desafio_auth_totp/src/service/totp/i_totp_service.dart';

class AuthRepository implements IAuthRepository {
  final IRemoteDatasource _remoteDatasource;
  final ITotpService _totpService;
  AuthRepository(this._remoteDatasource, this._totpService);
  @override
  Future<UserModel> login({
    required String email,
    required String password,
    required String secret,
  }) async {
    final code = await generateTotp(secret);
    return await _remoteDatasource.login(
        email: email, password: password, totp: code);
  }

  @override
  Future<String> generateTotp(String secret) async {
    return _totpService.generateTotp(secret);
  }

  @override
  Future<String> requestSecret(
      {required String email,
      required String password,
      required String code}) async {
    try {
      final result = await _remoteDatasource.requestSecret(
          email: email, password: password, code: code);
      return result;
    } catch (e) {
      if (e is CustomException) {
        rethrow;
      }

      throw Exception('Error requesting secret');
    }
  }

  @override
  Future<bool> isValidCredentials(
      {required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    return email == 'admin' && password == 'password123';
  }
}
