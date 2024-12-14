import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';
import 'package:lilac_task/features/home/view/pages/home_page.dart';
import 'package:lilac_task/features/home/view/pages/message_screen.dart';
import 'package:lilac_task/features/home/view/pages/profile_screen.dart';
import 'package:lilac_task/features/home/view/pages/requirements_screen.dart';
import 'package:lilac_task/features/home/view/pages/sell_screen.dart';

final selectedNavIndex = StateProvider<int>(
  (ref) => 0,
);

class NavPage extends ConsumerWidget {
  NavPage({super.key});

  final pages = [
    HomePage(),
    MessageScreen(),
    SellScreen(),
    RequirementsScreen(),
    ProfileScreen()
  ];
  final List<Map<String, dynamic>> m = [
    {"name": "Profile", "icon": Icons.person},
    {"name": "Messages", "icon": Icons.message},
    {"name": "Sell", "icon": Icons.sell},
    {"name": "Requirements", "icon": Icons.assignment},
    {"name": "Profile", "icon": Icons.person},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: GoogleFonts.poppins(color: Pallete.brownColor),
        unselectedLabelStyle: GoogleFonts.poppins(color: Pallete.greyColor),
        currentIndex: ref.watch(selectedNavIndex),
        onTap: (value) {
          ref.read(selectedNavIndex.notifier).update(
                (state) => value,
              );
        },
        items: List.generate(
          pages.length,
          (index) {
            return BottomNavigationBarItem(
              icon: Icon(
                m[index]['icon'] as IconData,
                color: Pallete.blackColor,
              ),
              label: m[index]['name'],
            );
          },
        ),
      ),
      body: pages[ref.watch(selectedNavIndex)],
    );
  }
}
