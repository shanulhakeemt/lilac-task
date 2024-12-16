import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isObscured = StateProvider<bool>(
  (ref) => true,
);

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onTap,
    this.isSufficxIcon = false,
  });
  final String hintText;
  final TextEditingController? controller;
  final bool isSufficxIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return TextFormField(
        onTap: onTap,
        validator: (value) {
          if (value!.trim().isEmpty) {
            return "$hintText is missing";
          }
          return null;
        },
        controller: controller,
        obscureText: !isSufficxIcon ? false : ref.watch(isObscured),
        decoration: InputDecoration(
          suffixIcon: !isSufficxIcon
              ? null
              : IconButton(
                  onPressed: () {
                    ref.read(isObscured.notifier).update(
                          (state) => !state,
                        );
                  },
                  icon: Icon(ref.watch(isObscured)
                      ? CupertinoIcons.eye_slash_fill
                      : CupertinoIcons.eye)),
          hintText: hintText,
        ),
      );
    });
  }
}
