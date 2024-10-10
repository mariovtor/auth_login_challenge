import 'package:desafio_auth_totp/src/core/app_assets.dart';
import 'package:desafio_auth_totp/src/core/app_theme.dart';
import 'package:desafio_auth_totp/src/core/locator.dart';
import 'package:desafio_auth_totp/src/core/text_validators.dart';
import 'package:desafio_auth_totp/src/core/widgets/snackbar_error.dart';
import 'package:desafio_auth_totp/src/features/auth/bloc/auth_cubit.dart';
import 'package:desafio_auth_totp/src/features/auth/bloc/auth_state.dart';
import 'package:desafio_auth_totp/src/features/auth/secret/secret_verify_page.dart';
import 'package:desafio_auth_totp/src/features/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const pageName = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final cubit = getIt<AuthCubit>();
  bool showPassword = false;

  static const imageHorizontalAdjust = 40.0;
  static const imageVerticalAdjust = 24.0;

  InputDecoration inputDecoration({required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(.14),
      suffixIcon: suffix,
    );
  }

  void onLogin() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    cubit.login();
  }

  void toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is AuthRequestSecret) {
            Navigator.of(context).pushNamed(SecretVerifyPage.pageName);
            return;
          }
          if (state is AuthStateAuthenticated) {
            Navigator.of(context).pushReplacementNamed(HomePage.pageName);
            return;
          }
          if (state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackbarError(state.error));
            cubit.clearError();
          }
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Stack(
                  children: [
                    Positioned(
                      right: -imageHorizontalAdjust,
                      bottom: imageVerticalAdjust,
                      child: SizedBox(
                        width: width + imageHorizontalAdjust,
                        child: Image.asset(
                          AppAssets.loginVector1,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -imageHorizontalAdjust,
                      top: imageVerticalAdjust,
                      child: SizedBox(
                        width: width + imageHorizontalAdjust,
                        child: Image.asset(
                          AppAssets.loginVector2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 70.0),
                            child: Image.asset(
                              AppAssets.loginImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: inputDecoration(hint: 'E-mail'),
                          keyboardType: TextInputType.emailAddress,
                          validator: TextValidators.validateEmail,
                          onChanged: cubit.setEmail,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: inputDecoration(
                            hint: 'Senha',
                            suffix: IconButton(
                              icon: Icon(showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: toggleShowPassword,
                            ),
                          ),
                          obscureText: !showPassword,
                          validator: TextValidators.validatePassword,
                          onChanged: cubit.setPassword,
                          onFieldSubmitted: (_) => onLogin(),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: BlocBuilder<AuthCubit, AuthState>(
                                  bloc: cubit,
                                  builder: (context, state) {
                                    if (state.isLoading) {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                        color: AppTheme.primary,
                                      ));
                                    }
                                    return ElevatedButton(
                                      onPressed: onLogin,
                                      child: const Text('Entrar'),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    //TODO forgot password action
                  },
                  child: const Text('Esqueci a senha'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
