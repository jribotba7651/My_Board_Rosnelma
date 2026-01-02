import 'package:my_board/imports.dart';

import 'story_board_controller.dart';

class StoryBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StoryBoardController());
  }
}
