abstract class IHttpService {
  Future<Map<String, dynamic>> post({
    required String url,
    Map<String, dynamic>? body,
  });
}
