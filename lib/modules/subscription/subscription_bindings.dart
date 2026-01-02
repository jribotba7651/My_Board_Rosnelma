import 'package:my_board/imports.dart';
import 'package:my_board/modules/subscription/subsciption_controller.dart';

class ChangeCardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SubscriptionController());
  }
}
