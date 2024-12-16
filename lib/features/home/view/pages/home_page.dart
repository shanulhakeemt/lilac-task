import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task/core/common/variables.dart';
import 'package:lilac_task/core/constants/asset_constants.dart';
import 'package:lilac_task/features/home/view/widgets/custom_card.dart';
import 'package:lilac_task/features/home/viewmodel/list_of_vehicles.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final List<Map<String, String>> m = [
    {
      "name": "Total Vehicle",
      "img": AssetConstants.firstImage,
      "count": '100',
    },
    {
      "name": "Total Bookings",
      "img": AssetConstants.secondImage,
      "count": '50',
    },
    {
      "name": "C2B Concept",
      "img": AssetConstants.thirdImage,
      "count": '25',
    },
    {
      "name": "Vehicle For Sale",
      "img": AssetConstants.forthImage,
      "count": '35',
    },
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await ref.read(listOfVehiclesViewModelProvider.notifier).getVehicles();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            CupertinoIcons.list_bullet,
            size: w * .081,
          ),
          actions: [
            SizedBox(
                width: w * .15,
                child: Icon(
                  CupertinoIcons.bell,
                  size: w * .081,
                ))
          ],
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of items per row
            crossAxisSpacing: 10.0, // Horizontal spacing
            mainAxisSpacing: 10.0, // Vertical spacing
          ),
          itemCount: 4, // Total number of items
          itemBuilder: (context, index) {
            return CustomCard(
              m: m[index],
              index: index,
            );
          },
          padding:
              const EdgeInsets.all(10.0), // Optional padding around the grid
        ));
  }
}
