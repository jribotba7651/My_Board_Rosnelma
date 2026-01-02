// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:my_board/core/api_service.dart';
import 'package:my_board/core/values/api_constant.dart';
import 'package:my_board/data/models/user_model.dart';
import 'package:my_board/imports.dart';

class DashBoardHomeController extends GetxController {
  bool dataLoading = true;
  TextEditingController codeCtrl = TextEditingController();
  UserModel? currentUser = UserModel();

  getCurrentUser() async {
    try {
      var data = await APIService()
          .getDataWithAPIWithoutContext(url: EndPoint.getProfile);
      if (data != null) {
        currentUser = UserModel.fromJson(data["user"]);
        print("_______________________________________ ${currentUser!.name}");
        update();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void onInit() {
    getCurrentUser();
    super.onInit();
  }
}
