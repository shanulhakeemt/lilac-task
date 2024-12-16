import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';
import 'package:lilac_task/core/widgets/loader.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.isLoading = false});

  final String buttonText;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallete.brownColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Pallete.transparentColor,
          backgroundColor: Pallete.transparentColor,
          fixedSize: const Size(395, 55),
        ),
        onPressed: onPressed,
        child: isLoading
            ? Loader(
                color: Pallete.whiteColor,
              )
            : Text(
                buttonText,
                style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Pallete.backgroundColor),
              ),
      ),
    );
  }
}
