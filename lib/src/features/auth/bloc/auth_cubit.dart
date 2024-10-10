import 'package:desafio_auth_totp/src/domain/repositories/i_auth_repository.dart';
import 'package:desafio_auth_totp/src/features/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthLogin(isLoading: false));

  final IAuthRepository _authRepository;

  String? secret;
  String? email;
  String? password;

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  Future<void> login() async {
    emit(AuthLogin(isLoading: true));
    email ??= '';
    password ??= '';

    if (secret == null) {
      emit(AuthRequestSecret(isLoading: false));
      return;
    }
    await handleError(() async {
      final user = await _authRepository.login(
          email: email!, password: password!, secret: secret!);

      emit(AuthStateAuthenticated(user: user, isLoading: false));
    });
  }

  Future<void> requestSecret(String code) async {
    emit(AuthRequestSecret(isLoading: true));
    await handleError(() async {
      secret = await _authRepository.requestSecret(
          email: email ?? '', password: password ?? '', code: code);
      emit(AuthLogin(isLoading: false));
    });
  }

  Future<void> handleError(Future Function() f) async {
    try {
      await f();
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void clearError() {
    emit(state.copyWith(error: ''));
  }
}
