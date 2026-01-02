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

  ///_________________________________ GET LKIGAI
  getFamilyTree() async {
    try {
      dataLoading = true;
      update();
      dynamic data = await APIService().getDataWithAPIWithoutContextforFamily(
        url: EndPoint.getfamilyTree,
      );
      print(data);
      if (data != null) {
        print("__________________________ ${familyTree.ownerName}");
        familyTree = FamilyTreeModel.fromJson(data);
        print("__________________________ ${familyTree.ownerName}");
        dataLoading = false;
        update();
      }
      dataLoading = false;
      update();
    } catch (error) {
      dataLoading = false;
      update();
      // Show.showErrorSnackBar("Error", "Something Went Wrong");
    }
  }

  bool postingData = false;

  ///_________________________________ SUBMIT LKIGAI
  addFamilyMember(BuildContext context) async {
    if (fnameCtrl.text.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add First Name");
    } else if (lnameCtrl.text.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Add First Name");
    } else if (dobCtrl.text.isEmpty) {
      Show.showErrorSnackBar("Error", "Please Select DOB");
    } else {
      var body = {
        "relation": selectedRelation,
        "memberData": {
          "firstName": fnameCtrl.text,
          "lastName": lnameCtrl.text,
          "dob": dobCtrl.text,
          "image": "",
          "isAlive": islive
        }
      };
      print(body);
      try {
        postingData = true;
        update();
        bool result = await APIService().postDataWithAPI(
            url: EndPoint.addFamilyMember, data: body, context: context);
        if (result) {
          postingData = false;
          fnameCtrl.clear();
          lnameCtrl.clear();
          dobCtrl.clear();
          dodCtrl.clear();
          await getFamilyTree();
          Get.back();
        } else {
          postingData = false;
          update();
        }
      } catch (error) {
        postingData = false;
        update();
        debugPrint("Error $error");
      }
    }
  }

  @override
  void onInit() {
    getFamilyTree();
    super.onInit();
  }
}
