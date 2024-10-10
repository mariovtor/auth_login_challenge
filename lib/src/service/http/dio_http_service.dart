import 'package:desafio_auth_totp/src/core/custom_exception.dart';
import 'package:desafio_auth_totp/src/service/http/i_http_service.dart';
import 'package:dio/dio.dart';

class DioHttpService implements IHttpService {
  final dio = Dio();
  @override
  Future<Map<String, dynamic>> post(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await dio.postUri(Uri.parse(url),
          data: body, options: Options(headers: headers));
      return response.data;
    } catch (e) {
      if (e is DioException) {
        throw CustomException(e.response?.data['message'] ?? e.message);
      }

      rethrow;
    }
  }
}
