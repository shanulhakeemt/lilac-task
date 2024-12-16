import 'package:flutter/cupertino.dart';
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
    {"name": "Home", "icon": CupertinoIcons.house},
    {"name": "Messages", "icon": CupertinoIcons.bubble_middle_bottom},
    {"name": "Sell", "icon": CupertinoIcons.money_dollar_circle},
    {"name": "Requirements", "icon": CupertinoIcons.add},
    {"name": "Profile", "icon": CupertinoIcons.person},
  ];
  final List<IconData> selectedIconsList = [
    CupertinoIcons.house_fill,
    CupertinoIcons.bubble_middle_top_fill,
    CupertinoIcons.money_dollar_circle_fill,
    CupertinoIcons.add_circled_solid,
    CupertinoIcons.person_alt,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Pallete.whiteColor,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w400),
        selectedItemColor: Pallete.brownColor,
        unselectedItemColor: Pallete.brownColor,
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
              backgroundColor: Pallete.whiteColor,
              icon: Icon(
                index == ref.watch(selectedNavIndex)
                    ? selectedIconsList[ref.watch(selectedNavIndex)]
                    : m[index]['icon'] as IconData,
                color: Pallete.brownColor,
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
