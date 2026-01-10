// ignore_for_file: depend_on_referenced_packages, avoid_print, deprecated_member_use

import 'dart:math';
import 'package:my_board/data/models/quantum_card_model.dart';
import 'package:my_board/core/values/show.dart';
import '../../../../imports.dart';

class QuantumDeckController extends GetxController {
  // Observable variables
  var dailyCards = <QuantumCardModel>[].obs;
  var weeklyCards = <QuantumCardModel>[].obs;
  var monthlyCards = <QuantumCardModel>[].obs;

  var isLoading = false.obs;
  var lastShuffleTime = DateTime.now().obs;

  // Deterministic algorithm state
  int _seed = 0;
  Random? _random;

  @override
  void onInit() {
    super.onInit();
    _initializeSeed();
    generateInitialCards();
  }

  // Initialize deterministic seed based on current date
  void _initializeSeed() {
    final now = DateTime.now();
    // Create deterministic seed based on current date
    _seed = now.year * 10000 + now.month * 100 + now.day;
    _random = Random(_seed);
    print('Quantum Deck initialized with seed: $_seed');
  }

  // Generate initial cards for all periods
  void generateInitialCards() {
    isLoading.value = true;

    try {
      // Generate cards for each period
      dailyCards.value = _generateCardsForPeriod('daily', 3);
      weeklyCards.value = _generateCardsForPeriod('weekly', 5);
      monthlyCards.value = _generateCardsForPeriod('monthly', 8);

      lastShuffleTime.value = DateTime.now();
    } catch (e) {
      print('Error generating initial cards: $e');
      Show.showErrorSnackBar('Error', 'Failed to generate quantum cards');
    } finally {
      isLoading.value = false;
    }
  }

  // Shuffle deck - regenerate all cards
  void shuffleDeck() {
    isLoading.value = true;

    try {
      // Update seed for new randomization
      _seed = DateTime.now().millisecondsSinceEpoch % 1000000;
      _random = Random(_seed);

      // Regenerate all cards
      dailyCards.value = _generateCardsForPeriod('daily', 3);
      weeklyCards.value = _generateCardsForPeriod('weekly', 5);
      monthlyCards.value = _generateCardsForPeriod('monthly', 8);

      lastShuffleTime.value = DateTime.now();

      Show.showSuccessSnackBar('Quantum Deck', 'Cards shuffled successfully!');
    } catch (e) {
      print('Error shuffling deck: $e');
      Show.showErrorSnackBar('Error', 'Failed to shuffle deck');
    } finally {
      isLoading.value = false;
    }
  }

  // Get cards for specific type (daily/weekly/monthly)
  List<QuantumCardModel> getCardsForType(String type) {
    switch (type.toLowerCase()) {
      case 'daily':
        return dailyCards;
      case 'weekly':
        return weeklyCards;
      case 'monthly':
        return monthlyCards;
      default:
        return [];
    }
  }

  // Generate cards for a specific period
  List<QuantumCardModel> _generateCardsForPeriod(String period, int count) {
    final cards = <QuantumCardModel>[];
    final cardTemplates = _getCardTemplates(period);

    if (cardTemplates.isEmpty) return cards;

    // Use deterministic selection
    final selectedTemplates = <Map<String, dynamic>>[];

    for (int i = 0; i < count && cardTemplates.isNotEmpty; i++) {
      final index = _random!.nextInt(cardTemplates.length);
      final template = cardTemplates[index];

      // Avoid duplicates in same period
      if (!selectedTemplates.contains(template)) {
        selectedTemplates.add(template);
      } else if (cardTemplates.length > count) {
        // Try to find another card if duplicates exist
        final alternativeIndex = (index + 1) % cardTemplates.length;
        final alternativeTemplate = cardTemplates[alternativeIndex];
        if (!selectedTemplates.contains(alternativeTemplate)) {
          selectedTemplates.add(alternativeTemplate);
        }
      }
    }

    // Create card models
    for (int i = 0; i < selectedTemplates.length; i++) {
      final template = selectedTemplates[i];
      cards.add(QuantumCardModel(
        id: '${period}_${i + 1}_${DateTime.now().millisecondsSinceEpoch}',
        title: template['title'],
        description: template['description'],
        category: template['category'],
        period: period,
        estimatedTime: template['estimatedTime'],
        difficulty: template['difficulty'],
        tags: List<String>.from(template['tags']),
        instructions: List<String>.from(template['instructions']),
        benefits: List<String>.from(template['benefits']),
        createdAt: DateTime.now(),
      ));
    }

    return cards;
  }

  // Get card templates based on period
  List<Map<String, dynamic>> _getCardTemplates(String period) {
    switch (period.toLowerCase()) {
      case 'daily':
        return _getDailyTemplates();
      case 'weekly':
        return _getWeeklyTemplates();
      case 'monthly':
        return _getMonthlyTemplates();
      default:
        return [];
    }
  }

  // Daily card templates
  List<Map<String, dynamic>> _getDailyTemplates() {
    return [
      {
        'title': 'Morning Mindfulness',
        'description': 'Start your day with 10 minutes of mindful breathing',
        'category': 'Mindfulness',
        'estimatedTime': 10,
        'difficulty': 'Easy',
        'tags': ['morning', 'breathing', 'calm'],
        'instructions': [
          'Find a quiet space',
          'Sit comfortably with eyes closed',
          'Focus on your breath for 10 minutes',
          'Notice thoughts without judgment'
        ],
        'benefits': ['Reduced stress', 'Better focus', 'Improved mood']
      },
      {
        'title': 'Creative Sketch',
        'description': 'Draw something you see around you for 15 minutes',
        'category': 'Creativity',
        'estimatedTime': 15,
        'difficulty': 'Easy',
        'tags': ['art', 'observation', 'creativity'],
        'instructions': [
          'Get paper and pencil',
          'Choose an object nearby',
          'Draw for 15 minutes without erasing',
          'Focus on observation, not perfection'
        ],
        'benefits': ['Enhanced creativity', 'Better observation skills', 'Stress relief']
      },
      {
        'title': 'Gratitude Journal',
        'description': 'Write down three things you are grateful for today',
        'category': 'Reflection',
        'estimatedTime': 5,
        'difficulty': 'Easy',
        'tags': ['gratitude', 'writing', 'positivity'],
        'instructions': [
          'Get a notebook or open notes app',
          'Write three specific things you\'re grateful for',
          'Include why each matters to you',
          'Feel the emotion as you write'
        ],
        'benefits': ['Increased happiness', 'Better perspective', 'Improved relationships']
      },
      {
        'title': 'Power Walk',
        'description': 'Take a brisk 20-minute walk outdoors',
        'category': 'Wellness',
        'estimatedTime': 20,
        'difficulty': 'Easy',
        'tags': ['exercise', 'outdoor', 'energy'],
        'instructions': [
          'Put on comfortable shoes',
          'Step outside',
          'Walk at a brisk pace for 20 minutes',
          'Notice your surroundings'
        ],
        'benefits': ['Better cardiovascular health', 'Increased energy', 'Vitamin D']
      },
      {
        'title': 'Focus Sprint',
        'description': 'Work on one important task for 25 minutes without distractions',
        'category': 'Focus',
        'estimatedTime': 25,
        'difficulty': 'Medium',
        'tags': ['productivity', 'concentration', 'pomodoro'],
        'instructions': [
          'Choose one important task',
          'Remove all distractions',
          'Set timer for 25 minutes',
          'Work with complete focus'
        ],
        'benefits': ['Increased productivity', 'Better focus habits', 'Sense of accomplishment']
      }
    ];
  }

  // Weekly card templates
  List<Map<String, dynamic>> _getWeeklyTemplates() {
    return [
      {
        'title': 'Weekly Planning Session',
        'description': 'Plan and prioritize your upcoming week',
        'category': 'Focus',
        'estimatedTime': 30,
        'difficulty': 'Medium',
        'tags': ['planning', 'organization', 'goals'],
        'instructions': [
          'Review last week\'s accomplishments',
          'List this week\'s priorities',
          'Schedule important tasks',
          'Set 3 main goals for the week'
        ],
        'benefits': ['Better organization', 'Clearer priorities', 'Reduced stress']
      },
      {
        'title': 'Digital Detox Day',
        'description': 'Spend one day with minimal screen time',
        'category': 'Wellness',
        'estimatedTime': 480,
        'difficulty': 'Hard',
        'tags': ['detox', 'mindfulness', 'balance'],
        'instructions': [
          'Turn off non-essential notifications',
          'Engage in offline activities',
          'Read a physical book',
          'Spend time in nature'
        ],
        'benefits': ['Improved sleep', 'Better relationships', 'Increased mindfulness']
      }
    ];
  }

  // Monthly card templates
  List<Map<String, dynamic>> _getMonthlyTemplates() {
    return [
      {
        'title': 'Monthly Review & Reflection',
        'description': 'Deep dive into your personal growth this month',
        'category': 'Reflection',
        'estimatedTime': 60,
        'difficulty': 'Medium',
        'tags': ['review', 'goals', 'growth'],
        'instructions': [
          'Review your monthly goals',
          'Identify what worked well',
          'Note areas for improvement',
          'Set intentions for next month'
        ],
        'benefits': ['Self-awareness', 'Goal alignment', 'Continuous improvement']
      },
      {
        'title': 'Learn a New Skill',
        'description': 'Dedicate this month to learning something completely new',
        'category': 'Creativity',
        'estimatedTime': 1200,
        'difficulty': 'Hard',
        'tags': ['learning', 'skill', 'growth'],
        'instructions': [
          'Choose a skill you\'ve always wanted to learn',
          'Find quality learning resources',
          'Practice for 30 minutes daily',
          'Track your progress'
        ],
        'benefits': ['New capabilities', 'Increased confidence', 'Mental stimulation']
      }
    ];
  }

  // Mark card as completed
  void markCardAsCompleted(String cardId) {
    // Find and update card across all lists
    _markCardCompletedInList(dailyCards, cardId);
    _markCardCompletedInList(weeklyCards, cardId);
    _markCardCompletedInList(monthlyCards, cardId);

    Show.showSuccessSnackBar('Well Done!', 'Card completed successfully');
  }

  void _markCardCompletedInList(RxList<QuantumCardModel> list, String cardId) {
    final index = list.indexWhere((card) => card.id == cardId);
    if (index != -1) {
      final updatedCard = list[index].copyWith(isCompleted: true);
      list[index] = updatedCard;
    }
  }
}