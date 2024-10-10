abstract class ITotpService {
  Future<String> generateTotp(String secret);
}
