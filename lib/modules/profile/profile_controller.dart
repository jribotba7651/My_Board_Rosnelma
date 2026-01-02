// ignore_for_file: empty_catches, avoid_print, use_build_context_synchronously

import 'package:my_board/core/api_service.dart';
import 'package:my_board/core/values/api_constant.dart';
import 'package:my_board/data/models/user_model.dart';
import 'package:my_board/imports.dart';

class ProfileController extends GetxController {
  String userName = "";
  String email = "";
  UserModel user = UserModel();
  bool dataLoading = false;

  getProfile() async {
    try {
      dataLoading = true;
      update();
      var data = await await APIService()
          .getDataWithAPIWithoutContext(url: EndPoint.getProfile);
      if (data != null) {
        user = UserModel.fromJson(data["user"]);
        userName = user.name!;
        email = user.email!;
        dataLoading = false;
        update();
      }
    } catch (error) {
      dataLoading = false;
      update();
    }
  }



  deleteSession(String id, BuildContext context) async {
    String endPoint = "${EndPoint.deleteSession}$id";
    try {
      dataLoading = true;
      update();
      bool result =
          await APIService().deleteDataWithAPI(url: endPoint, context: context);

      if (result == true) {
        Navigator.of(context).pop();
        update();
      } else {
        dataLoading = false;
        update();
      }
    } catch (error) {
      dataLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
