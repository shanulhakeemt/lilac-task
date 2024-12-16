import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilac_task/core/common/variables.dart';
import 'package:lilac_task/core/constants/asset_constants.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';
import 'package:lilac_task/core/ustils.dart';
import 'package:lilac_task/features/home/view/pages/add_requirement.dart';

class SelectRequirementCategory extends StatelessWidget {
  SelectRequirementCategory({super.key});
  final List<String> cateImgs = [AssetConstants.carImg, AssetConstants.bikeImg];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back)),
        title: Text(
          'What would you prefer to have?',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: w * .042,
              color: Pallete.blackColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * .08, vertical: h * .08),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            2,
            (index) {
              return SelectCatCard(
                imgText: cateImgs[index],
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }
}

class SelectCatCard extends StatelessWidget {
  const SelectCatCard({
    super.key,
    required this.imgText,
    required this.index,
  });
  final String imgText;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 1) {
          showSnackBar(context, 'Temporarily, the bike is not accessible.');
        } else {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddRequirement('${index + 1}');
            },
          ));
        }
      },
      child: Container(
          height: h * .19,
          width: w * .36,
          decoration: BoxDecoration(
              color: Pallete.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Black shadow with opacity
                  blurRadius: 2, // How blurry the shadow is
                  offset: const Offset(1, 1), // Horizontal and vertical offset
                ),
              ],
              borderRadius: BorderRadius.circular(2)),
          child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: w * .03, vertical: h * .03),
              child: Center(
                child: Image.asset(imgText),
              ))),
    );
  }
}
