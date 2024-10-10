import 'package:flutter/material.dart';

class SnackbarError extends SnackBar {
  SnackbarError(String text, {super.key})
      : super(
          content: Text(text),
          backgroundColor: const Color(0xff212229),
          margin: const EdgeInsets.all(4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          behavior: SnackBarBehavior.floating,
        );
}
