import 'package:my_board/imports.dart';
import 'visual_board_controller.dart';

class VisualBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(VisualBoardController());
  }
}
