import 'package:flutter/material.dart';

import '../colors.dart';

Text customText(String text) {
  return Text(
    ' $text',
    style: TextStyle(
        fontFamily: 'Neohellenic',
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
        color: AppColors().date),
  );
}
