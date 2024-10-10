import 'package:desafio_auth_totp/src/data/datasource/i_remote_datasource.dart';
import 'package:desafio_auth_totp/src/data/datasource/remote_datasource_local.dart';
import 'package:desafio_auth_totp/src/data/repositories/auth_repository.dart';
import 'package:desafio_auth_totp/src/domain/repositories/i_auth_repository.dart';
import 'package:desafio_auth_totp/src/features/auth/bloc/auth_cubit.dart';
import 'package:desafio_auth_totp/src/service/http/dio_http_service.dart';
import 'package:desafio_auth_totp/src/service/http/i_http_service.dart';
import 'package:desafio_auth_totp/src/service/totp/i_totp_service.dart';
import 'package:desafio_auth_totp/src/service/totp/totp_service.dart';
import 'package:get_it/get_it.dart';

GetIt get getIt => GetIt.instance;

class Locator {
  Future<void> initDependencies() async {
    await _registerServices();
    await _registerData();
    await _registerRepositories();
    await _registerBlocs();
  }

  Future<void> _registerServices() async {
    getIt.registerSingleton<IHttpService>(DioHttpService());
    getIt.registerSingleton<ITotpService>(TotpService());
  }

  Future<void> _registerData() async {
    getIt.registerFactory<IRemoteDatasource>(
        () => RemoteDatasourceLocal(getIt()));
  }

  Future<void> _registerRepositories() async {
    getIt.registerFactory<IAuthRepository>(
        () => AuthRepository(getIt(), getIt()));
  }

  Future<void> _registerBlocs() async {
    getIt.registerSingleton(AuthCubit(getIt()));
  }
}
