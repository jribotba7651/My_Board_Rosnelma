import 'package:my_board/modules/profile/profile_controller.dart';

import '../../imports.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}
