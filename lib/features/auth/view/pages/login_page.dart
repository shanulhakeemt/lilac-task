import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilac_task/core/common/variables.dart';
import 'package:lilac_task/core/constants/asset_constants.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';
import 'package:lilac_task/core/ustils.dart';
import 'package:lilac_task/core/widgets/custom_field.dart';
import 'package:lilac_task/core/widgets/loader.dart';
import 'package:lilac_task/core/widgets/custom_button.dart';
import 'package:lilac_task/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lilac_task/features/home/view/pages/home_page.dart';
import 'package:lilac_task/features/home/view/pages/nav_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    final isLoading = ref.watch(authViewModelProvider.select(
      (value) => value?.isLoading == true,
    ));
    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => NavPage(),
              ),
              (_) => false,
            );
          },
          error: (error, stackTrace) {
            showSnackBar(context, error.toString());
          },
          loading: () {},
        );
      },
    );

    return Scaffold(
      body: isLoading
          ? const Loader()
          : Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: w * .05, vertical: h * .05),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: h * .08,
                      ),
                      Container(
                        width: w * .2,
                        height: w * .2,
                        decoration: BoxDecoration(
                            color: Pallete.brownColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Image.asset(AssetConstants.logoIcon),
                        ),
                      ),
                      SizedBox(
                        height: h * .03,
                      ),
                      SizedBox(
                        width: w * .5,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Login With Your Email & Password",
                          style: GoogleFonts.poppins(
                              fontSize: w * .04, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: h * .1,
                      ),
                      CustomField(
                        controller: emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomField(
                        controller: passController,
                        isObscuredText: true,
                        hintText: "Password",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await ref
                                .read(authViewModelProvider.notifier)
                                .loginUser(
                                    email: emailController.text.trim(),
                                    password: passController.text.trim());
                          }
                        },
                        buttonText: "Sign in",
                      ),
                      SizedBox(
                        height: h * .21,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: RichText(
                          text: TextSpan(
                              text: "Don't have an account? ",
                              style: Theme.of(context).textTheme.titleMedium,
                              children: const [
                                TextSpan(
                                    text: "Register",
                                    style: TextStyle(
                                        color: Pallete.blue,
                                        fontWeight: FontWeight.bold))
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
