import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilac_task/core/common/variables.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';
import 'package:lilac_task/core/widgets/custom_button.dart';
import 'package:lilac_task/features/home/view/pages/select_requirement_category.dart';

class RequirementsScreen extends StatelessWidget {
  RequirementsScreen({super.key});
  final l1 = ['Automatic', 'Petrol', 'Black'];
  final l2 = ['Transmission', 'Fuel', 'Color'];

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        title: Text(
          'Requirement List',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .08, vertical: h * .05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Pallete.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.2), // Black shadow with opacity
                        blurRadius: 2, // How blurry the shadow is
                        offset: const Offset(
                            1, 1), // Horizontal and vertical offset
                      ),
                    ],
                    borderRadius: BorderRadius.circular(2)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * .03, vertical: h * .03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Rolls Roys Ghost Standard (2020)',
                        style: GoogleFonts.poppins(
                            fontSize: w * .03, fontWeight: FontWeight.bold),
                      ),
                      ...List.generate(
                        3,
                        (index) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text(l1[index]), Text(l2[index])],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Active"),
                          Switch(
                            value: true,
                            onChanged: (value) {},
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            CustomButton(
              buttonText: '+ Create A Requirement',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return SelectRequirementCategory();
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
