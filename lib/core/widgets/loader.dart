import 'package:flutter/material.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.color = Pallete.brownColor});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Pallete.brownColor.withOpacity(.4),
        backgroundColor: color,
      ),
    );
  }
}
