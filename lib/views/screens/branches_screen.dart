import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_buddy/views/screens/years_screen.dart';

import '../../common/constants/asset_constants.dart';
import '../../controllers/data_controller.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  List<String> branchNames = [
    "Computer Science",
    "Civil",
    "Mechanical",
    "Electrical",
  ];

  List<String> branchImages = [
    AssetConstants.computerEng,
    AssetConstants.civilEng,
    AssetConstants.mechanicalEng,
    AssetConstants.electricalEng,
  ];

  var dataController = Get.put(DataController());

  @override
  void initState() {
    super.initState();

    branchNames =
        dataController.branchesAndYearsModel.value.data!.branches!.toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      itemCount: branchNames.length,
      itemBuilder: (_, index) {
        return Card(
          elevation: 8.0,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            // leading: Image.asset(branchImages[index]),
            leading: Image.asset(AssetConstants.mechanicalEng),
            title: Text(
              branchNames[index],
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Get.to(
                () => YearsScreen(
                  branchName: branchNames[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
