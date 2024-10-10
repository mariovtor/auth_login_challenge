class TextValidators {
  TextValidators._();

  static String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return 'É necessário preencher o campo de email';
    }

    // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
    //   return 'Por favor entre com um email válido';
    // }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return 'É necessário preencher o campo de senha';
    }

    return null;
  }
}
