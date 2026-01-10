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

  // Get today's single card using deterministic algorithm
  QuantumCardModel getTodaysCard() {
    final now = DateTime.now();
    final cardTemplates = _getDailyTemplates();

    // Calculate day of year (1-366)
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays + 1;

    // Add seasonal offset for more variety
    final seasonalOffset = (now.month * 3) % 40;

    // Deterministic index calculation
    final cardIndex = (dayOfYear + seasonalOffset) % cardTemplates.length;
    final template = cardTemplates[cardIndex];

    // Create today's card
    return QuantumCardModel(
      id: 'daily_card_${now.year}_${now.month}_${now.day}',
      title: template['title'],
      description: template['description'],
      category: template['category'],
      period: 'daily',
      estimatedTime: template['estimatedTime'],
      difficulty: template['difficulty'],
      tags: List<String>.from(template['tags']),
      instructions: List<String>.from(template['instructions']),
      benefits: List<String>.from(template['benefits']),
      createdAt: now,
    );
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

  // The 40 Quantum Deck Astrological Cards
  List<Map<String, dynamic>> _getDailyTemplates() {
    return [
      // Fire Signs
      {
        'title': 'Aries ♈ Sun',
        'description': 'Channel your pioneering spirit and take bold initiative today',
        'category': 'Fire',
        'estimatedTime': 15,
        'difficulty': 'Medium',
        'zodiac': 'Aries',
        'planet': 'Sun',
        'element': 'Fire',
        'modality': 'Cardinal',
        'symbol': '♈',
        'keyword': 'Initiate',
        'tags': ['leadership', 'courage', 'beginning'],
        'instructions': [
          'Identify a project that excites you',
          'Take the first bold step today',
          'Lead with confidence and enthusiasm',
          'Trust your instincts and pioneer new paths'
        ],
        'benefits': ['Increased leadership', 'Personal empowerment', 'New opportunities']
      },
      {
        'title': 'Aries ♈ Moon',
        'description': 'Honor your emotional impulses and express your authentic feelings',
        'category': 'Fire',
        'estimatedTime': 10,
        'difficulty': 'Easy',
        'zodiac': 'Aries',
        'planet': 'Moon',
        'element': 'Fire',
        'modality': 'Cardinal',
        'symbol': '♈',
        'keyword': 'Express',
        'tags': ['emotion', 'authenticity', 'spontaneity'],
        'instructions': [
          'Notice your immediate emotional responses',
          'Express feelings honestly and directly',
          'Act on positive emotional impulses',
          'Practice emotional courage in relationships'
        ],
        'benefits': ['Emotional authenticity', 'Stronger relationships', 'Self-awareness']
      },
      {
        'title': 'Aries ♈ Mercury',
        'description': 'Communicate with directness and mental agility',
        'category': 'Fire',
        'estimatedTime': 20,
        'difficulty': 'Medium',
        'zodiac': 'Aries',
        'planet': 'Mercury',
        'element': 'Fire',
        'modality': 'Cardinal',
        'symbol': '♈',
        'keyword': 'Declare',
        'tags': ['communication', 'quick thinking', 'debate'],
        'instructions': [
          'Speak your truth with confidence',
          'Make quick decisions when needed',
          'Engage in stimulating conversations',
          'Express ideas with passion and clarity'
        ],
        'benefits': ['Clear communication', 'Mental agility', 'Confident expression']
      },
      {
        'title': 'Aries ♈ Venus',
        'description': 'Pursue what you love with passionate intensity',
        'category': 'Fire',
        'estimatedTime': 30,
        'difficulty': 'Easy',
        'zodiac': 'Aries',
        'planet': 'Venus',
        'element': 'Fire',
        'modality': 'Cardinal',
        'symbol': '♈',
        'keyword': 'Pursue',
        'tags': ['love', 'passion', 'desire'],
        'instructions': [
          'Identify what truly excites you',
          'Take action toward your desires',
          'Express affection boldly',
          'Embrace new romantic or creative adventures'
        ],
        'benefits': ['Passionate relationships', 'Creative fulfillment', 'Personal magnetism']
      },
      {
        'title': 'Aries ♈ Mars',
        'description': 'Channel your warrior energy into productive action',
        'category': 'Fire',
        'estimatedTime': 25,
        'difficulty': 'Hard',
        'zodiac': 'Aries',
        'planet': 'Mars',
        'element': 'Fire',
        'modality': 'Cardinal',
        'symbol': '♈',
        'keyword': 'Conquer',
        'tags': ['action', 'strength', 'competition'],
        'instructions': [
          'Choose a challenging goal',
          'Apply focused physical or mental effort',
          'Compete with yourself to improve',
          'Channel anger into constructive action'
        ],
        'benefits': ['Achievement', 'Physical strength', 'Mental toughness']
      },
      {
        'title': 'Leo ♌ Sun',
        'description': 'Shine your light brightly and inspire others with your authentic self',
        'category': 'Fire',
        'estimatedTime': 20,
        'difficulty': 'Medium',
        'zodiac': 'Leo',
        'planet': 'Sun',
        'element': 'Fire',
        'modality': 'Fixed',
        'symbol': '♌',
        'keyword': 'Radiate',
        'tags': ['creativity', 'performance', 'leadership'],
        'instructions': [
          'Express your unique talents proudly',
          'Take center stage in your area of expertise',
          'Inspire others through your example',
          'Create something that reflects your true self'
        ],
        'benefits': ['Self-confidence', 'Creative expression', 'Natural leadership']
      },
      {
        'title': 'Leo ♌ Moon',
        'description': 'Celebrate your emotions and seek recognition for your feelings',
        'category': 'Fire',
        'estimatedTime': 15,
        'difficulty': 'Easy',
        'zodiac': 'Leo',
        'planet': 'Moon',
        'element': 'Fire',
        'modality': 'Fixed',
        'symbol': '♌',
        'keyword': 'Celebrate',
        'tags': ['drama', 'warmth', 'generosity'],
        'instructions': [
          'Honor your need for emotional appreciation',
          'Express feelings with theatrical flair',
          'Give and receive heartfelt compliments',
          'Create emotional warmth in your relationships'
        ],
        'benefits': ['Emotional fulfillment', 'Stronger bonds', 'Self-appreciation']
      },
      {
        'title': 'Leo ♌ Mercury',
        'description': 'Communicate with dramatic flair and creative storytelling',
        'category': 'Fire',
        'estimatedTime': 25,
        'difficulty': 'Medium',
        'zodiac': 'Leo',
        'planet': 'Mercury',
        'element': 'Fire',
        'modality': 'Fixed',
        'symbol': '♌',
        'keyword': 'Perform',
        'tags': ['storytelling', 'charisma', 'entertainment'],
        'instructions': [
          'Tell stories that captivate your audience',
          'Use dramatic gestures when speaking',
          'Share ideas with enthusiasm and pride',
          'Make your communication memorable and engaging'
        ],
        'benefits': ['Charismatic communication', 'Memorable presence', 'Creative expression']
      },
      {
        'title': 'Leo ♌ Venus',
        'description': 'Love grandly and appreciate the finer things in life',
        'category': 'Fire',
        'estimatedTime': 30,
        'difficulty': 'Easy',
        'zodiac': 'Leo',
        'planet': 'Venus',
        'element': 'Fire',
        'modality': 'Fixed',
        'symbol': '♌',
        'keyword': 'Adore',
        'tags': ['luxury', 'romance', 'appreciation'],
        'instructions': [
          'Treat yourself to something beautiful',
          'Express love in grand romantic gestures',
          'Appreciate art, beauty, and luxury',
          'Show generous affection to loved ones'
        ],
        'benefits': ['Romantic fulfillment', 'Aesthetic appreciation', 'Generous love']
      },
      {
        'title': 'Leo ♌ Mars',
        'description': 'Act with courage and noble purpose to protect what you value',
        'category': 'Fire',
        'estimatedTime': 20,
        'difficulty': 'Hard',
        'zodiac': 'Leo',
        'planet': 'Mars',
        'element': 'Fire',
        'modality': 'Fixed',
        'symbol': '♌',
        'keyword': 'Defend',
        'tags': ['courage', 'protection', 'nobility'],
        'instructions': [
          'Stand up for what you believe in',
          'Protect those who cannot protect themselves',
          'Act with honor and integrity',
          'Channel competitive spirit into noble causes'
        ],
        'benefits': ['Moral courage', 'Leadership respect', 'Personal honor']
      },
      // Earth Signs
      {
        'title': 'Taurus ♉ Sun',
        'description': 'Ground yourself in practical wisdom and appreciate life\'s simple pleasures',
        'category': 'Earth',
        'estimatedTime': 30,
        'difficulty': 'Easy',
        'zodiac': 'Taurus',
        'planet': 'Sun',
        'element': 'Earth',
        'modality': 'Fixed',
        'symbol': '♉',
        'keyword': 'Stabilize',
        'tags': ['stability', 'comfort', 'nature'],
        'instructions': [
          'Spend time in nature or garden',
          'Enjoy a meal mindfully and slowly',
          'Focus on building long-term security',
          'Appreciate beauty and sensory pleasures'
        ],
        'benefits': ['Inner peace', 'Financial stability', 'Sensory enjoyment']
      },
      {
        'title': 'Virgo ♍ Sun',
        'description': 'Perfect your craft through detailed attention and practical service',
        'category': 'Earth',
        'estimatedTime': 45,
        'difficulty': 'Medium',
        'zodiac': 'Virgo',
        'planet': 'Sun',
        'element': 'Earth',
        'modality': 'Mutable',
        'symbol': '♍',
        'keyword': 'Perfect',
        'tags': ['precision', 'service', 'health'],
        'instructions': [
          'Organize and improve your workspace',
          'Focus on one skill to master today',
          'Help someone with practical assistance',
          'Pay attention to health and daily routines'
        ],
        'benefits': ['Skill mastery', 'Improved efficiency', 'Helpful service']
      },
      {
        'title': 'Capricorn ♑ Sun',
        'description': 'Climb steadily toward your long-term goals with disciplined effort',
        'category': 'Earth',
        'estimatedTime': 60,
        'difficulty': 'Hard',
        'zodiac': 'Capricorn',
        'planet': 'Sun',
        'element': 'Earth',
        'modality': 'Cardinal',
        'symbol': '♑',
        'keyword': 'Achieve',
        'tags': ['ambition', 'discipline', 'success'],
        'instructions': [
          'Set a challenging but achievable goal',
          'Create a step-by-step plan to reach it',
          'Take one concrete action today',
          'Build on existing foundations methodically'
        ],
        'benefits': ['Goal achievement', 'Professional success', 'Personal discipline']
      },
      // Air Signs
      {
        'title': 'Gemini ♊ Sun',
        'description': 'Explore multiple interests and connect diverse ideas',
        'category': 'Air',
        'estimatedTime': 20,
        'difficulty': 'Easy',
        'zodiac': 'Gemini',
        'planet': 'Sun',
        'element': 'Air',
        'modality': 'Mutable',
        'symbol': '♊',
        'keyword': 'Connect',
        'tags': ['curiosity', 'communication', 'versatility'],
        'instructions': [
          'Learn something new and interesting',
          'Have conversations with different types of people',
          'Make connections between unrelated ideas',
          'Explore multiple perspectives on a topic'
        ],
        'benefits': ['Mental stimulation', 'Social connections', 'Intellectual growth']
      },
      {
        'title': 'Libra ♎ Sun',
        'description': 'Seek harmony and balance in all areas of your life',
        'category': 'Air',
        'estimatedTime': 25,
        'difficulty': 'Medium',
        'zodiac': 'Libra',
        'planet': 'Sun',
        'element': 'Air',
        'modality': 'Cardinal',
        'symbol': '♎',
        'keyword': 'Balance',
        'tags': ['harmony', 'relationships', 'justice'],
        'instructions': [
          'Mediate a conflict or disagreement',
          'Create beauty and harmony in your environment',
          'Consider all sides before making decisions',
          'Strengthen partnerships through compromise'
        ],
        'benefits': ['Peaceful relationships', 'Fair solutions', 'Aesthetic harmony']
      },
      {
        'title': 'Aquarius ♒ Sun',
        'description': 'Innovate for the greater good and embrace your uniqueness',
        'category': 'Air',
        'estimatedTime': 30,
        'difficulty': 'Medium',
        'zodiac': 'Aquarius',
        'planet': 'Sun',
        'element': 'Air',
        'modality': 'Fixed',
        'symbol': '♒',
        'keyword': 'Innovate',
        'tags': ['innovation', 'freedom', 'humanity'],
        'instructions': [
          'Think of an unconventional solution to a problem',
          'Connect with like-minded individuals',
          'Contribute to a cause larger than yourself',
          'Embrace what makes you different and unique'
        ],
        'benefits': ['Social impact', 'Innovation', 'Personal freedom']
      },
      // Water Signs
      {
        'title': 'Cancer ♋ Sun',
        'description': 'Nurture yourself and others with compassionate care',
        'category': 'Water',
        'estimatedTime': 25,
        'difficulty': 'Easy',
        'zodiac': 'Cancer',
        'planet': 'Sun',
        'element': 'Water',
        'modality': 'Cardinal',
        'symbol': '♋',
        'keyword': 'Nurture',
        'tags': ['family', 'emotion', 'protection'],
        'instructions': [
          'Create a comfortable, safe space for yourself',
          'Reach out to family or close friends',
          'Prepare or share a meal with love',
          'Trust your intuitive feelings about people'
        ],
        'benefits': ['Emotional security', 'Strong family bonds', 'Intuitive wisdom']
      },
      {
        'title': 'Scorpio ♏ Sun',
        'description': 'Transform through deep emotional exploration and regeneration',
        'category': 'Water',
        'estimatedTime': 40,
        'difficulty': 'Hard',
        'zodiac': 'Scorpio',
        'planet': 'Sun',
        'element': 'Water',
        'modality': 'Fixed',
        'symbol': '♏',
        'keyword': 'Transform',
        'tags': ['depth', 'mystery', 'transformation'],
        'instructions': [
          'Explore a deep emotional or psychological truth',
          'Release something that no longer serves you',
          'Investigate hidden aspects of a situation',
          'Embrace profound change and regeneration'
        ],
        'benefits': ['Personal transformation', 'Psychological insight', 'Emotional strength']
      },
      {
        'title': 'Pisces ♓ Sun',
        'description': 'Flow with intuition and connect to universal compassion',
        'category': 'Water',
        'estimatedTime': 35,
        'difficulty': 'Easy',
        'zodiac': 'Pisces',
        'planet': 'Sun',
        'element': 'Water',
        'modality': 'Mutable',
        'symbol': '♓',
        'keyword': 'Flow',
        'tags': ['intuition', 'compassion', 'spirituality'],
        'instructions': [
          'Meditate or engage in spiritual practice',
          'Listen to your intuition and dreams',
          'Practice compassion for all beings',
          'Express yourself through art or music'
        ],
        'benefits': ['Spiritual connection', 'Intuitive guidance', 'Emotional healing']
      },
      // Additional Planetary Combinations
      {
        'title': 'Sagittarius ♐ Sun',
        'description': 'Explore new horizons and expand your philosophical understanding',
        'category': 'Fire',
        'estimatedTime': 35,
        'difficulty': 'Medium',
        'zodiac': 'Sagittarius',
        'planet': 'Sun',
        'element': 'Fire',
        'modality': 'Mutable',
        'symbol': '♐',
        'keyword': 'Explore',
        'tags': ['adventure', 'philosophy', 'truth'],
        'instructions': [
          'Plan an adventure or learning experience',
          'Study a different philosophy or belief system',
          'Share your knowledge and wisdom with others',
          'Seek truth through direct experience'
        ],
        'benefits': ['Expanded worldview', 'Adventure fulfillment', 'Wisdom sharing']
      },
      {
        'title': 'Gemini ♊ Mercury',
        'description': 'Communicate ideas rapidly and connect disparate concepts',
        'category': 'Air',
        'estimatedTime': 15,
        'difficulty': 'Easy',
        'zodiac': 'Gemini',
        'planet': 'Mercury',
        'element': 'Air',
        'modality': 'Mutable',
        'symbol': '♊',
        'keyword': 'Network',
        'tags': ['networking', 'information', 'versatility'],
        'instructions': [
          'Gather information from multiple sources',
          'Make new social or professional connections',
          'Practice quick thinking and wit',
          'Share interesting facts with others'
        ],
        'benefits': ['Network expansion', 'Information mastery', 'Mental agility']
      },
      {
        'title': 'Taurus ♉ Venus',
        'description': 'Cultivate beauty, comfort, and sensual pleasure',
        'category': 'Earth',
        'estimatedTime': 40,
        'difficulty': 'Easy',
        'zodiac': 'Taurus',
        'planet': 'Venus',
        'element': 'Earth',
        'modality': 'Fixed',
        'symbol': '♉',
        'keyword': 'Appreciate',
        'tags': ['beauty', 'luxury', 'comfort'],
        'instructions': [
          'Indulge in a beautiful sensory experience',
          'Create or appreciate art and beauty',
          'Enjoy quality food, music, or nature',
          'Invest in something that brings lasting value'
        ],
        'benefits': ['Aesthetic pleasure', 'Comfort enhancement', 'Value creation']
      },
      {
        'title': 'Scorpio ♏ Mars',
        'description': 'Channel intense focus and transformational power',
        'category': 'Water',
        'estimatedTime': 30,
        'difficulty': 'Hard',
        'zodiac': 'Scorpio',
        'planet': 'Mars',
        'element': 'Water',
        'modality': 'Fixed',
        'symbol': '♏',
        'keyword': 'Penetrate',
        'tags': ['intensity', 'investigation', 'transformation'],
        'instructions': [
          'Investigate something deeply and thoroughly',
          'Transform a challenging situation',
          'Use focused intensity to overcome obstacles',
          'Eliminate what no longer serves your purpose'
        ],
        'benefits': ['Deep insight', 'Obstacle removal', 'Personal power']
      },
      {
        'title': 'Aquarius ♒ Mercury',
        'description': 'Think innovatively and communicate revolutionary ideas',
        'category': 'Air',
        'estimatedTime': 25,
        'difficulty': 'Medium',
        'zodiac': 'Aquarius',
        'planet': 'Mercury',
        'element': 'Air',
        'modality': 'Fixed',
        'symbol': '♒',
        'keyword': 'Revolutionize',
        'tags': ['innovation', 'technology', 'progress'],
        'instructions': [
          'Brainstorm unconventional solutions',
          'Use technology to solve problems',
          'Share progressive ideas with groups',
          'Challenge outdated thinking patterns'
        ],
        'benefits': ['Innovative solutions', 'Technological advancement', 'Social progress']
      },
      {
        'title': 'Cancer ♋ Moon',
        'description': 'Honor your emotional needs and nurture your inner child',
        'category': 'Water',
        'estimatedTime': 20,
        'difficulty': 'Easy',
        'zodiac': 'Cancer',
        'planet': 'Moon',
        'element': 'Water',
        'modality': 'Cardinal',
        'symbol': '♋',
        'keyword': 'Comfort',
        'tags': ['emotion', 'security', 'home'],
        'instructions': [
          'Create emotional safety for yourself',
          'Connect with family or chosen family',
          'Honor your feelings without judgment',
          'Create a nurturing environment at home'
        ],
        'benefits': ['Emotional security', 'Family bonds', 'Inner peace']
      },
      {
        'title': 'Virgo ♍ Mercury',
        'description': 'Analyze details carefully and communicate with precision',
        'category': 'Earth',
        'estimatedTime': 35,
        'difficulty': 'Medium',
        'zodiac': 'Virgo',
        'planet': 'Mercury',
        'element': 'Earth',
        'modality': 'Mutable',
        'symbol': '♍',
        'keyword': 'Analyze',
        'tags': ['precision', 'analysis', 'service'],
        'instructions': [
          'Break down complex problems into manageable parts',
          'Edit and refine your work or communication',
          'Offer practical advice or assistance',
          'Focus on improving health and daily routines'
        ],
        'benefits': ['Problem solving', 'Communication clarity', 'Health improvement']
      },
      {
        'title': 'Libra ♎ Venus',
        'description': 'Create harmony in relationships and appreciate beauty',
        'category': 'Air',
        'estimatedTime': 30,
        'difficulty': 'Easy',
        'zodiac': 'Libra',
        'planet': 'Venus',
        'element': 'Air',
        'modality': 'Cardinal',
        'symbol': '♎',
        'keyword': 'Harmonize',
        'tags': ['relationships', 'beauty', 'balance'],
        'instructions': [
          'Bring balance to an unequal situation',
          'Create beauty in your environment',
          'Strengthen partnerships through cooperation',
          'Practice diplomacy in challenging conversations'
        ],
        'benefits': ['Relationship harmony', 'Aesthetic environment', 'Peaceful resolution']
      },
      {
        'title': 'Capricorn ♑ Mars',
        'description': 'Apply disciplined effort toward ambitious long-term goals',
        'category': 'Earth',
        'estimatedTime': 45,
        'difficulty': 'Hard',
        'zodiac': 'Capricorn',
        'planet': 'Mars',
        'element': 'Earth',
        'modality': 'Cardinal',
        'symbol': '♑',
        'keyword': 'Manifest',
        'tags': ['ambition', 'persistence', 'mastery'],
        'instructions': [
          'Set a concrete milestone for a major goal',
          'Apply sustained effort to a challenging project',
          'Build authority and expertise in your field',
          'Take responsibility for important outcomes'
        ],
        'benefits': ['Goal achievement', 'Professional authority', 'Mastery development']
      },
      {
        'title': 'Pisces ♓ Venus',
        'description': 'Love unconditionally and express compassion for all beings',
        'category': 'Water',
        'estimatedTime': 25,
        'difficulty': 'Easy',
        'zodiac': 'Pisces',
        'planet': 'Venus',
        'element': 'Water',
        'modality': 'Mutable',
        'symbol': '♓',
        'keyword': 'Compassion',
        'tags': ['love', 'spirituality', 'sacrifice'],
        'instructions': [
          'Practice unconditional love and acceptance',
          'Offer help to those in need',
          'Express yourself through spiritual or artistic means',
          'Forgive past hurts and embrace healing'
        ],
        'benefits': ['Unconditional love', 'Spiritual growth', 'Emotional healing']
      },
      // Outer Planet Combinations
      {
        'title': 'Sagittarius ♐ Jupiter',
        'description': 'Expand your knowledge and share wisdom generously',
        'category': 'Fire',
        'estimatedTime': 40,
        'difficulty': 'Medium',
        'zodiac': 'Sagittarius',
        'planet': 'Jupiter',
        'element': 'Fire',
        'modality': 'Mutable',
        'symbol': '♐',
        'keyword': 'Expand',
        'tags': ['wisdom', 'teaching', 'philosophy'],
        'instructions': [
          'Learn something that expands your worldview',
          'Teach or mentor someone in your area of expertise',
          'Explore different cultures or philosophies',
          'Share your knowledge generously with others'
        ],
        'benefits': ['Wisdom expansion', 'Teaching fulfillment', 'Cultural understanding']
      },
      {
        'title': 'Capricorn ♑ Saturn',
        'description': 'Build lasting structures through patient, disciplined effort',
        'category': 'Earth',
        'estimatedTime': 60,
        'difficulty': 'Hard',
        'zodiac': 'Capricorn',
        'planet': 'Saturn',
        'element': 'Earth',
        'modality': 'Cardinal',
        'symbol': '♑',
        'keyword': 'Structure',
        'tags': ['discipline', 'responsibility', 'mastery'],
        'instructions': [
          'Create a solid foundation for future success',
          'Accept responsibility for important outcomes',
          'Practice discipline in a key area of life',
          'Build something that will last over time'
        ],
        'benefits': ['Long-term success', 'Personal mastery', 'Lasting achievement']
      },
      // Special Combinations
      {
        'title': 'Universal Balance',
        'description': 'Find equilibrium between all elements of your being',
        'category': 'Spirit',
        'estimatedTime': 30,
        'difficulty': 'Medium',
        'zodiac': 'Universal',
        'planet': 'Balance',
        'element': 'Spirit',
        'modality': 'Special',
        'symbol': '⚖️',
        'keyword': 'Equilibrium',
        'tags': ['balance', 'integration', 'wholeness'],
        'instructions': [
          'Balance physical, mental, emotional, and spiritual needs',
          'Find the middle way in a challenging situation',
          'Integrate opposing forces within yourself',
          'Practice moderation in all things'
        ],
        'benefits': ['Inner harmony', 'Integrated wholeness', 'Sustainable balance']
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
          'Practice mindful reading or meditation',
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