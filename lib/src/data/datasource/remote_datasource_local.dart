import 'package:desafio_auth_totp/src/data/datasource/i_remote_datasource.dart';
import 'package:desafio_auth_totp/src/domain/models/user_model.dart';
import 'package:desafio_auth_totp/src/service/http/i_http_service.dart';

///To use this api you need to redirect the 5000 port to the 5000 port of the local machine
///adb reverse tcp:5000 tcp:5000
class RemoteDatasourceLocal implements IRemoteDatasource {
  static const baseUrl = 'http://127.0.0.1:5000';
  final IHttpService _httpService;
  RemoteDatasourceLocal(this._httpService);
  @override
  Future<UserModel> login(
      {required String email,
      required String password,
      required String totp}) async {
    try {
      final response = await _httpService.post(
        url: '$baseUrl/auth/login',
        body: {
          'username': email,
          'password': password,
          'totp_code': totp,
        },
      );
      return UserModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> requestSecret(
      {required String email,
      required String password,
      required String code}) async {
    try {
      final response = await _httpService.post(
        url: '$baseUrl/auth/recovery-secret',
        body: {
          'username': email,
          'password': password,
          'code': code,
        },
      );
      return response['totp_secret'];
    } catch (e) {
      rethrow;
    }
  }
}
