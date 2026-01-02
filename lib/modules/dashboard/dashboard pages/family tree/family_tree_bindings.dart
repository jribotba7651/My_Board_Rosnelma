
import '../../../../imports.dart';
import 'family_tree_controller.dart';

class FamilyTreeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(FamilyTreeController());
  }
}
