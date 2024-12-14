import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task/core/theme/theme.dart';
import 'package:lilac_task/features/auth/view/pages/login_page.dart';
import 'package:lilac_task/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lilac_task/features/home/view/pages/nav_page.dart';
import 'package:lilac_task/features/splash/pages/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      theme: AppTheme.lightThemeMode,
      home: SplashScreen(),
    );
  }
}
