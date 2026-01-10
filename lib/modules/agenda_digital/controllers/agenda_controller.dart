import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AgendaController extends GetxController {
  // Date management
  var selectedDate = DateTime.now().obs;

  // Current quantum card
  var currentCard = Rxn<dynamic>();

  // Page 1 - Card Reflection controllers
  late final TextEditingController reflection1Controller;
  late final TextEditingController reflection2Controller;
  late final TextEditingController reflection3Controller;

  // Page 2 - Planning controllers
  late final TextEditingController priority1Controller;
  late final TextEditingController priority2Controller;
  late final TextEditingController priority3Controller;

  // Time blocks (6am to 11pm = 18 hours)
  final int totalTimeBlocks = 18;

  // Water tracking (8 glasses)
  late final RxList<RxBool> waterGlasses;

  // Meals
  late final TextEditingController breakfastController;
  late final TextEditingController lunchController;
  late final TextEditingController dinnerController;

  // Page 3 - Reflection controllers
  late final TextEditingController cardManifestationController;
  late final TextEditingController win1Controller;
  late final TextEditingController win2Controller;
  late final TextEditingController win3Controller;
  late final TextEditingController lessonsLearnedController;
  late final TextEditingController freeNotesController;
  late final TextEditingController gratitudeController;

  // Checkboxes for evening check-in
  var completedPriorities = false.obs;
  var practicedSelfCare = false.obs;
  var connectedWithOthers = false.obs;
  var honoredEnergy = false.obs;

  // Rating (1-10)
  var rating = 0.obs;

  // Quantum deck data
  final List<Map<String, dynamic>> quantumCards = [
    {
      'id': 1,
      'title': 'Aries Mars Impulse',
      'description': 'Channel your fiery energy into decisive action today',
      'category': 'fire',
      'tags': ['leadership', 'courage'],
      'estimatedTime': 15,
      'difficulty': 'Medium'
    },
    {
      'id': 2,
      'title': 'Taurus Venus Stability',
      'description': 'Ground yourself in beauty and practical abundance',
      'category': 'earth',
      'tags': ['stability', 'luxury'],
      'estimatedTime': 20,
      'difficulty': 'Easy'
    },
    // Add more cards as needed...
  ];

  late final List<TextEditingController> timeBlockControllers = [];
  late final List<TextEditingController> priorityControllers;
  late final List<TextEditingController> mealControllers;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    loadCardOfTheDay();
  }

  void _initializeControllers() {
    // Page 1 controllers
    reflection1Controller = TextEditingController();
    reflection2Controller = TextEditingController();
    reflection3Controller = TextEditingController();

    // Page 2 controllers
    priority1Controller = TextEditingController();
    priority2Controller = TextEditingController();
    priority3Controller = TextEditingController();

    // Time block controllers (6am to 11pm = 18 hours)
    for (int i = 0; i < totalTimeBlocks; i++) {
      timeBlockControllers.add(TextEditingController());
    }

    // Initialize the missing controller lists
    priorityControllers = [priority1Controller, priority2Controller, priority3Controller];
    mealControllers = [breakfastController, lunchController, dinnerController];

    // Water tracking
    waterGlasses = List.generate(8, (_) => false.obs).obs;

    // Meal controllers
    breakfastController = TextEditingController();
    lunchController = TextEditingController();
    dinnerController = TextEditingController();

    // Update meal controllers list after initialization
    mealControllers.clear();
    mealControllers.addAll([breakfastController, lunchController, dinnerController]);

    // Page 3 controllers
    cardManifestationController = TextEditingController();
    win1Controller = TextEditingController();
    win2Controller = TextEditingController();
    win3Controller = TextEditingController();
    lessonsLearnedController = TextEditingController();
    freeNotesController = TextEditingController();
    gratitudeController = TextEditingController();
  }

  void onDateChanged(DateTime newDate) {
    selectedDate.value = newDate;
    loadCardOfTheDay();
  }

  void loadCardOfTheDay() {
    // Use date-based deterministic card selection
    final dayOfYear = selectedDate.value.difference(DateTime(selectedDate.value.year, 1, 1)).inDays;
    final cardIndex = dayOfYear % quantumCards.length;
    currentCard.value = quantumCards[cardIndex];
  }

  // Page 1 - Save card reflection data
  void saveCardData() {
    if (reflection1Controller.text.trim().isEmpty ||
        reflection2Controller.text.trim().isEmpty ||
        reflection3Controller.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please complete all reflection fields',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Save card reflection data
    final cardData = {
      'date': DateFormat('yyyy-MM-dd').format(selectedDate.value),
      'cardId': currentCard.value?.id,
      'reflection1': reflection1Controller.text.trim(),
      'reflection2': reflection2Controller.text.trim(),
      'reflection3': reflection3Controller.text.trim(),
    };

    print('Saving card data: $cardData');

    Get.snackbar(
      'Success',
      'Daily reflection saved successfully!',
      backgroundColor: Color(0xFF008B8B),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  // Page 2 - Save planning data
  void savePlanningData() {
    // Collect priorities
    final priorities = [
      priority1Controller.text.trim(),
      priority2Controller.text.trim(),
      priority3Controller.text.trim(),
    ].where((p) => p.isNotEmpty).toList();

    // Collect time blocks
    final timeBlocks = <String, String>{};
    for (int i = 0; i < timeBlockControllers.length; i++) {
      final hour = 6 + i; // Starting from 6am
      final time = hour < 12 ? '${hour}:00 AM'
                  : hour == 12 ? '12:00 PM'
                  : '${hour - 12}:00 PM';
      if (timeBlockControllers[i].text.trim().isNotEmpty) {
        timeBlocks[time] = timeBlockControllers[i].text.trim();
      }
    }

    // Collect water tracking
    final waterCount = waterGlasses.where((glass) => glass.value).length;

    // Collect meals
    final meals = {
      'breakfast': breakfastController.text.trim(),
      'lunch': lunchController.text.trim(),
      'dinner': dinnerController.text.trim(),
    };

    final planningData = {
      'date': DateFormat('yyyy-MM-dd').format(selectedDate.value),
      'priorities': priorities,
      'timeBlocks': timeBlocks,
      'waterCount': waterCount,
      'meals': meals,
    };

    print('Saving planning data: $planningData');

    Get.snackbar(
      'Success',
      'Daily planning saved successfully!',
      backgroundColor: Color(0xFF008B8B),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  // Page 2 - Save method alias
  void savePage2() {
    savePlanningData();
  }

  // Page 3 - Save reflection data
  void saveReflectionData() {
    if (rating.value == 0) {
      Get.snackbar(
        'Validation Error',
        'Please rate your day',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final reflectionData = {
      'date': DateFormat('yyyy-MM-dd').format(selectedDate.value),
      'rating': rating.value,
      'completedPriorities': completedPriorities.value,
      'practicedSelfCare': practicedSelfCare.value,
      'connectedWithOthers': connectedWithOthers.value,
      'honoredEnergy': honoredEnergy.value,
      'cardManifestation': cardManifestationController.text.trim(),
      'wins': [
        win1Controller.text.trim(),
        win2Controller.text.trim(),
        win3Controller.text.trim(),
      ].where((w) => w.isNotEmpty).toList(),
      'lessonsLearned': lessonsLearnedController.text.trim(),
      'freeNotes': freeNotesController.text.trim(),
      'gratitude': gratitudeController.text.trim(),
    };

    print('Saving reflection data: $reflectionData');

    Get.snackbar(
      'Success',
      'Daily reflection completed successfully!',
      backgroundColor: Color(0xFF008B8B),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    // Dispose all controllers
    reflection1Controller.dispose();
    reflection2Controller.dispose();
    reflection3Controller.dispose();

    priority1Controller.dispose();
    priority2Controller.dispose();
    priority3Controller.dispose();

    for (final controller in timeBlockControllers) {
      controller.dispose();
    }

    breakfastController.dispose();
    lunchController.dispose();
    dinnerController.dispose();

    cardManifestationController.dispose();
    win1Controller.dispose();
    win2Controller.dispose();
    win3Controller.dispose();
    lessonsLearnedController.dispose();
    freeNotesController.dispose();
    gratitudeController.dispose();

    super.onClose();
  }
}