import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextStyles {
  middle,
  small;

  TextStyle get style {
    switch (this) {
      case TextStyles.middle:
        return GoogleFonts.ephesis(
          textStyle: TextStyle(
            color: const Color(0xFFd3be8a).withOpacity(0.5),
            fontSize: 64,
            decoration: TextDecoration.none,
          ),
        );
      case TextStyles.small:
        return GoogleFonts.ephesis(
          textStyle: TextStyle(
            color: const Color(0xFFd3be8a).withOpacity(0.5),
            fontSize: 24,
            decoration: TextDecoration.none,
          ),
        );
    }
  }
}
