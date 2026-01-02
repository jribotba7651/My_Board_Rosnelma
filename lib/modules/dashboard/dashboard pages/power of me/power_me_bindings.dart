import 'package:my_board/imports.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/power%20of%20me/power_me_controller.dart';

class PowerMeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PowerMeController());
  }
}
