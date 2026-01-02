import 'package:my_board/imports.dart';

import 'lkigai_board_controller.dart';



class LkigaiBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LkigaiBoardController());
  }
}
