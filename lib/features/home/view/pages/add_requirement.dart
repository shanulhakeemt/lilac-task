import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lilac_task/core/common/variables.dart';
import 'package:lilac_task/core/theme/app_pallete.dart';
import 'package:lilac_task/core/widgets/custom_button.dart';
import 'package:lilac_task/features/home/viewmodel/home_viewmodel.dart';

final selectedTransmissionIndex = StateProvider(
  (ref) {
    return 0;
  },
);

class AddRequirement extends ConsumerStatefulWidget {
  const AddRequirement({super.key});

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
          style: GoogleFonts.poppins(),
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
                  children: [
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
                                  height: h * .05,
                                  width: w * .38,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ref.watch(
                                                      selectedTransmissionIndex) ==
                                                  index
                                              ? Pallete.blackColor
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
                                          color: Pallete.blackColor),
                                    ),
                                  )),
                            );
                          });
                        })
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * .03, vertical: h * .01),
                            decoration: BoxDecoration(
                              color:
                                  Colors.white, // Background color of dropdown
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
                              dropdownColor: Pallete.transparentColor,
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
                      ),
                    )
                  ],
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * .03, vertical: h * .01),
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
                ),
              );
            }),
            CustomButton(
              buttonText: 'Submit',
              onPressed: () async {
                await ref.read(homeViewmodelProvider.notifier).addRequirement();
              },
            )
          ]),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AddRequirement(),
  ));
}
