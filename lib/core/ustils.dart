import 'package:flutter/material.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
        SnackBar(backgroundColor: Pallete.brownColor, content: Text(content)));
}
