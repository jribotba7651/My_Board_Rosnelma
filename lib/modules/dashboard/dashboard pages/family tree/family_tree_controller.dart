import 'package:my_board/data/models/family_model.dart';
import 'package:my_board/imports.dart';

import '../../../../core/api_service.dart';
import '../../../../core/values/api_constant.dart';
import '../../../../core/values/show.dart';

class FamilyTreeController extends GetxController {
  bool islive = true;
  TextEditingController fnameCtrl = TextEditingController();
  TextEditingController lnameCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController dodCtrl = TextEditingController();

  final List<String> relations = [
    "Grandfather",
    "Grandmother",
    "Wife",
    "Husband",
    "Son",
    "Daughter",
    "Sibling",
    "Father",
    "Mother",
    "Brother",
    "Sister"
  ];

  String selectedRelation = "";

  changeLive(bool newVal) {
    islive = newVal;
    update();
  }

  bool dataLoading = true;
  FamilyTreeModel familyTree = FamilyTreeModel();

  ///_________________________________ GET FAMILY TREE DATA
  getFamilyTree() async {
    try {
      dataLoading = true;
      update();

      dynamic data = await APIService().getDataWithAPIWithoutContextforFamily(
        url: EndPoint.getfamilyTree,
      );

      print('Family Tree API Response: $data');

      if (data != null) {
        familyTree = FamilyTreeModel.fromJson(data);
        print("Family Tree Owner: ${familyTree.ownerName}");
      } else {
        // Initialize with empty data if no data found
        familyTree = FamilyTreeModel();
        print('No Family Tree data found, initializing with empty model');
      }

      dataLoading = false;
      update();

    } catch (error) {
      dataLoading = false;
      update();
      print('Error loading Family Tree data: $error');

      // Initialize with empty data on error
      familyTree = FamilyTreeModel();

      // Show user-friendly error message
      Get.snackbar(
        'Loading Error',
        'Failed to load family data. Please check your connection.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  bool postingData = false;

  ///_________________________________ ADD FAMILY MEMBER
  addFamilyMember(BuildContext context) async {
    try {
      // Validate all required fields
      if (fnameCtrl.text.trim().isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please add first name',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (lnameCtrl.text.trim().isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please add last name',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (dobCtrl.text.trim().isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please select date of birth',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      if (selectedRelation.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please select relationship',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // Show loading dialog
      Get.dialog(
        Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Color(0xFF008B8B)),
                SizedBox(height: 16),
                Text('Adding Family Member...'),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      var body = {
        "relation": selectedRelation,
        "memberData": {
          "firstName": fnameCtrl.text.trim(),
          "lastName": lnameCtrl.text.trim(),
          "dob": dobCtrl.text.trim(),
          "image": "",
          "isAlive": islive
        }
      };

      print("Adding Family Member: $body");

      postingData = true;
      update();

      bool result = await APIService().postDataWithAPI(
        url: EndPoint.addFamilyMember,
        data: body,
        context: context
      );

      postingData = false;
      update();

      // Close loading dialog
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      if (result) {
        // Success - clear form and refresh data
        fnameCtrl.clear();
        lnameCtrl.clear();
        dobCtrl.clear();
        dodCtrl.clear();
        selectedRelation = "";

        await getFamilyTree();

        Get.snackbar(
          'Success',
          'Family member added successfully!',
          backgroundColor: Color(0xFF008B8B),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );

        Get.back(); // Return to family tree
      } else {
        Get.snackbar(
          'Error',
          'Failed to add family member. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      postingData = false;
      update();

      // Close loading dialog if open
      if (Get.isDialogOpen == true) {
        Get.back();
      }

      debugPrint("Error adding family member: $error");

      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${error.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
    }
  }

  @override
  void onInit() {
    getFamilyTree();
    super.onInit();
  }
}
