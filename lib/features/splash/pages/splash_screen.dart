import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task/core/common/variables.dart';
import 'package:lilac_task/core/constants/asset_constants.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';
import 'package:lilac_task/features/auth/view/pages/login_page.dart';
import 'package:lilac_task/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lilac_task/features/home/view/pages/nav_page.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Future.delayed(Duration(seconds: 2));
        final token = ref.read(authViewModelProvider.notifier).getToken();
        if (token != null) {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => NavPage(),
              ),
              (route) => false,
            );
          }
        } else {
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (route) => false,
            );
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Center(
          child: Image.asset(width: w * .8, AssetConstants.splashLogo),
        ),
      ),
    );
  }
}
