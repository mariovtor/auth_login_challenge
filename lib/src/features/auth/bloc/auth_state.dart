// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:desafio_auth_totp/src/domain/models/user_model.dart';

class AuthState {
  final String error;
  final bool isLoading;

  AuthState({this.error = '', this.isLoading = false});

  AuthState copyWith({
    String? error,
    bool? isLoading,
  }) {
    return AuthState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthLogin extends AuthState {
  AuthLogin({
    super.isLoading,
    super.error,
  });

  @override
  AuthLogin copyWith({
    bool? isLoading,
    String? error,
  }) {
    return AuthLogin(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthRequestSecret extends AuthState {
  AuthRequestSecret({
    super.isLoading,
    super.error,
  });

  @override
  AuthRequestSecret copyWith({
    bool? isLoading,
    String? error,
  }) {
    return AuthRequestSecret(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthStateAuthenticated extends AuthState {
  final UserModel user;
  AuthStateAuthenticated({
    required this.user,
    super.isLoading,
    super.error,
  });

  @override
  AuthStateAuthenticated copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthStateAuthenticated(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
