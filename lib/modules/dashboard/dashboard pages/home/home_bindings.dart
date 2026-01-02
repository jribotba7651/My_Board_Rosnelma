import 'package:my_board/modules/dashboard/dashboard%20pages/home/home_controller.dart';

import '../../../../global_controllers/global_controller.dart';
import '../../../../imports.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashBoardHomeController());
     Get.put(GlobalController());
  }
}
