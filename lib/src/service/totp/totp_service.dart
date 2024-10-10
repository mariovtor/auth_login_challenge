import 'package:desafio_auth_totp/src/service/totp/i_totp_service.dart';
import 'package:otp/otp.dart' as otp;

class TotpService implements ITotpService {
  @override
  Future<String> generateTotp(String secret) async {
    try {
      return otp.OTP.generateTOTPCodeString(
        secret,
        DateTime.now().millisecondsSinceEpoch,
        interval: 30,
        algorithm: otp.Algorithm.SHA1,
        isGoogle: true,
      );
    } catch (e) {
      throw Exception('Erro ao gerar o TOTP');
    }
  }
}
