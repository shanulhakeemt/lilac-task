import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilac_task/core/common/variables.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';
import 'package:lilac_task/core/ustils.dart';
import 'package:lilac_task/core/widgets/custom_button.dart';
import 'package:lilac_task/features/home/view/pages/nav_page.dart';
import 'package:lilac_task/features/home/viewmodel/home_viewmodel.dart';

final selectedTransmissionIndex = StateProvider(
  (ref) {
    return 0;
  },
);

class AddRequirement extends ConsumerStatefulWidget {
  const AddRequirement(this.vehicleType, {super.key});

  final String vehicleType;

  @override
  // ignore: library_private_types_in_public_api
  _AddRequirementState createState() => _AddRequirementState();
}

class _AddRequirementState extends ConsumerState<AddRequirement> {
  // List of labels for the dropdowns
  final List<String> labels = [
    'Brand',
    'Label',
    'Name',
    'Year',
    'Fuel',
    'Color'
  ];
  final transmissions = ['Automatic', 'Manual'];

  // Options for each dropdown
  final Map<String, List<String>> dropdownOptions = {
    'Brand': ['Toyota', 'Honda', 'Ford', 'Tesla'],
    'Label': ['Sedan', 'SUV', 'Truck', 'Coupe'],
    'Name': ['Model S', 'Accord', 'Ranger', 'Camry'],
    'Year': ['2020', '2021', '2022', '2023'],
    'Fuel': ['Petrol', 'Diesel', 'Electric', 'Hybrid'],
    'Color': ['Red', 'Blue', 'White', 'Black'],
  };

  // Map to store selected values
  final Map<String, String?> selectedValues = {
    'Brand': null,
    'Label': null,
    'Name': null,
    'Year': null,
    'Fuel': null,
    'Color': null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Vehicle requirment',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: w * .05,
              color: Pallete.blackColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ...List.generate(labels.length, (index) {
              String label = labels[index];
              if (index == 4) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: h * .01,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Transmission',
                          style: GoogleFonts.poppins(
                              color: Pallete.blackColor,
                              fontSize: w * .04,
                              fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                                text: "*",
                                style: GoogleFonts.poppins(
                                    color: Pallete.red,
                                    fontSize: w * .04,
                                    fontWeight: FontWeight.w400))
                          ]),
                    ),
                    SizedBox(
                      height: h * .003,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(transmissions.length, (index) {
                          return Consumer(builder: (context, ref, child) {
                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(selectedTransmissionIndex.notifier)
                                    .update(
                                      (state) => index,
                                    );
                              },
                              child: Container(
                                  height: h * .064,
                                  width: w * .42,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ref.watch(
                                                      selectedTransmissionIndex) ==
                                                  index
                                              ? Pallete.brownColor
                                              : Pallete.transparentColor),
                                      color: Pallete.whiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                              0.2), // Black shadow with opacity
                                          blurRadius:
                                              2, // How blurry the shadow is
                                          offset: const Offset(1,
                                              1), // Horizontal and vertical offset
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      transmissions[index],
                                      style: GoogleFonts.poppins(
                                          fontSize: w * .04,
                                          fontWeight: FontWeight.w500,
                                          color: ref.watch(
                                                      selectedTransmissionIndex) ==
                                                  index
                                              ? Pallete.brownColor
                                              : Pallete.greyColor),
                                    ),
                                  )),
                            );
                          });
                        }),
                      ],
                    ),
                    SizedBox(
                      height: h * .012,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: label,
                              style: GoogleFonts.poppins(
                                  color: Pallete.blackColor,
                                  fontSize: w * .04,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                    text: "*",
                                    style: GoogleFonts.poppins(
                                        color: Pallete.red,
                                        fontSize: w * .04,
                                        fontWeight: FontWeight.w400))
                              ]),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: w * .03, vertical: h * .01),
                          decoration: BoxDecoration(
                            color: Pallete
                                .whiteColor, // Background color of dropdown
                            borderRadius:
                                BorderRadius.circular(8), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.1), // Shadow color
                                blurRadius: 10, // Blur intensity
                                offset: Offset(0, 4), // Offset of shadow
                              ),
                            ],
                            // Border color and width
                          ),
                          child: DropdownButton<String>(
                            underline:
                                const SizedBox(), // Removes the bottom indicator

                            dropdownColor: Pallete.whiteColor,
                            value: selectedValues[label],
                            isExpanded: true,
                            hint: Text('Select $label'),
                            items: dropdownOptions[label]!
                                .map((option) => DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(option),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValues[label] = value;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: label,
                          style: GoogleFonts.poppins(
                              color: Pallete.blackColor,
                              fontSize: w * .04,
                              fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                                text: "*",
                                style: GoogleFonts.poppins(
                                    color: Pallete.red,
                                    fontSize: w * .04,
                                    fontWeight: FontWeight.w400))
                          ]),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * .03, vertical: h * .012),
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color of dropdown
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.1), // Shadow color
                            blurRadius: 10, // Blur intensity
                            offset: Offset(0, 4), // Offset of shadow
                          ),
                        ],
                        // Border color and width
                      ),
                      child: DropdownButton<String>(
                        style: GoogleFonts.poppins(
                            color: Pallete.blackColor,
                            fontSize: w * .04,
                            fontWeight: FontWeight.w500),
                        underline:
                            const SizedBox(), // Removes the bottom indicator

                        dropdownColor: Pallete.whiteColor,
                        value: selectedValues[label],
                        isExpanded: true,
                        hint: Text(
                          'Select $label',
                          style: GoogleFonts.poppins(
                              fontSize: w * .04, fontWeight: FontWeight.w500),
                        ),
                        items: dropdownOptions[label]!
                            .map((option) => DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: GoogleFonts.poppins(
                                        fontSize: w * .04,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValues[label] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
            Consumer(builder: (context, ref, child) {
              final isLoading = ref.watch(homeViewmodelProvider.select(
                (value) => value?.isLoading == true,
              ));
              ref.listen(
                homeViewmodelProvider,
                (_, next) {
                  next?.when(
                    data: (data) {
                      showSnackBar(
                          context, 'Vehicle requirement created successfully.');

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

              return CustomButton(
                isLoading: isLoading,
                buttonText: 'Submit',
                onPressed: () async {
                  if (selectedValues['Brand'] == null ||
                      selectedValues['Label'] == null ||
                      selectedValues['Name'] == null ||
                      selectedValues['Year'] == null ||
                      selectedValues['Fuel'] == null ||
                      selectedValues['Color'] == null) {
                    showSnackBar(context, 'Please complete the all fields ');
                  } else {
                    await ref
                        .read(homeViewmodelProvider.notifier)
                        .addRequirement(
                          brandId: dropdownOptions['Brand']
                                  ?.indexOf(selectedValues['Brand'] ?? '')
                                  .toString() ??
                              '1',
                          fuelTypeId: dropdownOptions['Fuel']
                                  ?.indexOf(selectedValues['Fuel'] ?? '')
                                  .toString() ??
                              '1',
                          transmissionId:
                              "${ref.watch(selectedTransmissionIndex) + 1}",
                          vehicleColorId: dropdownOptions['Color']
                                  ?.indexOf(selectedValues['Color'] ?? '')
                                  .toString() ??
                              '1',
                          vehicleModelId: dropdownOptions['Label']
                                  ?.indexOf(selectedValues['Label'] ?? '')
                                  .toString() ??
                              '1',
                          vehicleTypeId: widget.vehicleType,
                          vehicleVarienteId: dropdownOptions['Name']
                                  ?.indexOf(selectedValues['Name'] ?? '')
                                  .toString() ??
                              '1',
                          year: dropdownOptions['Year']
                                  ?.indexOf(selectedValues['Year'] ?? '')
                                  .toString() ??
                              '1',
                        );
                  }
                },
              );
            })
          ]),
        ),
      ),
    );
  }
}
