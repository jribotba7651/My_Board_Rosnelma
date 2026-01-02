import '../../../../imports.dart';
import 'task_board_controller.dart';

class TaskBoardBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskBoardController());
  }
}
