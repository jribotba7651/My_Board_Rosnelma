import '../../../../imports.dart';
import 'quantum_deck_controller.dart';

class QuantumDeckBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(QuantumDeckController());
  }
}