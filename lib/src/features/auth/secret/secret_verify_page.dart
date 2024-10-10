import 'package:desafio_auth_totp/src/core/app_assets.dart';
import 'package:desafio_auth_totp/src/core/app_theme.dart';
import 'package:desafio_auth_totp/src/core/locator.dart';
import 'package:desafio_auth_totp/src/features/auth/bloc/auth_cubit.dart';
import 'package:desafio_auth_totp/src/features/auth/bloc/auth_state.dart';
import 'package:desafio_auth_totp/src/features/auth/login/login_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SecretVerifyPage extends StatefulWidget {
  const SecretVerifyPage({super.key});

  static const pageName = 'SecretVerifyPage';

  @override
  State<SecretVerifyPage> createState() => _SecretVerifyPageState();
}

class _SecretVerifyPageState extends State<SecretVerifyPage> {
  String code = '';
  static const pagePadding = 20.0;
  final focusNodes = List.generate(6, (i) => FocusNode());
  final controllers = List.generate(6, (i) => TextEditingController());

  final cubit = getIt<AuthCubit>();

  void onChanged(String value, int index) {
    setState(() {
      code = controllers.map((e) => e.text).join();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(pagePadding),
        child: BlocConsumer<AuthCubit, AuthState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is AuthLogin) {
                Navigator.popUntil(context,
                    (route) => route.settings.name == LoginPage.pageName);
                return;
              }
              if (state.error.isNotEmpty) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
                cubit.clearError();
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Verificação',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  const Text('Insira o código que foi enviado'),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(
                        6,
                        (i) => SizedBox(
                          width: MediaQuery.sizeOf(context).width / 5.8 -
                              (pagePadding),
                          child: TextFormField(
                            controller: controllers[i],
                            focusNode: focusNodes[i],
                            onChanged: (value) {
                              onChanged(value, i);
                              if (value.isEmpty) {
                                if (i > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                              }
                              if (value.length == 1) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                            decoration: const InputDecoration(
                              fillColor: Color(0xffF6F6F8),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: AppTheme.primary, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: Color(0xffe7e7e7)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: Color(0xffF6F6F8)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (state.isLoading)
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primary,
                      ),
                    ),
                  if (!state.isLoading)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: ElevatedButton(
                        onPressed: code.length != 6
                            ? null
                            : () {
                                cubit.requestSecret(code);
                              },
                        child: const Text('Confirmar'),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.messageQuestionIcon),
                      const SizedBox(width: 8),
                      const Text('Não recebi o código'),
                    ],
                  ),
                  const Spacer(flex: 2),
                ],
              );
            }),
      ),
    );
  }
}
