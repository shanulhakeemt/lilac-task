import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilac_task/core/common/variables.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';
import 'package:lilac_task/features/home/viewmodel/list_of_vehicles.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.index, required this.m});

  final int index;
  final Map<String, String> m;

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {},
        child: Container(
            decoration: BoxDecoration(
                color: Pallete.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.2), // Black shadow with opacity
                    blurRadius: 2, // How blurry the shadow is
                    offset:
                        const Offset(1, 1), // Horizontal and vertical offset
                  ),
                ],
                borderRadius: BorderRadius.circular(2)),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: w * .03, vertical: h * .03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(m['img']!),
                  Consumer(builder: (context, ref, child) {
                    final isLoading =
                        ref.watch(listOfVehiclesViewModelProvider).isLoading ==
                            true;
                    ;
                    final vehicles = ref.watch(listOfVehiclesViewModelProvider);
                    return Text(
                      index != 0
                          ? m['count']!
                          : isLoading
                              ? '0'
                              : vehicles.hasValue
                                  ? vehicles.value!.length.toString()
                                  : '',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: w * .033,
                          color: Colors.black),
                    );
                  }),
                  Text(
                    m['name']!,
                    style: GoogleFonts.poppins(
                        fontSize: w * .03, color: Colors.black),
                  ),
                ],
              ),
            )));
  
  
  }
}
