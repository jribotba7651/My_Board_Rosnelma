import 'package:my_board/core/api_service.dart';
import 'package:my_board/core/values/api_constant.dart';
import 'package:my_board/data/models/profile_model.dart';
import 'package:my_board/imports.dart';
import 'package:intl/intl.dart';

class GlobalController extends GetxController {
  ProfileModel currentUser = ProfileModel();
 showDatePickerWidget(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    return "${pickedDate!.day}-${pickedDate.month}-${pickedDate.year}";
  }

  getUser() async {
    try {
      var data = await APIService()
          .getDataWithAPIWithoutContext(url: EndPoint.getProfile);
      if (data['success'] == true) {
        currentUser = ProfileModel.fromJson(data["user"]);
        update();
      }
    } catch (error) {
      debugPrint("Error _______________________ $error");
    }
    await APIService().getDataWithAPIWithoutContext(url: EndPoint.getProfile);
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }
}

String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
  return formattedDate;
}

String formatTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedTime = DateFormat('hh:mm a').format(dateTime);
  return formattedTime;
}
