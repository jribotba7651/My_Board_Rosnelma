// ignore_for_file: avoid_print, deprecated_member_use

import 'dart:convert';
import 'package:my_board/data/models/quantum_card_model.dart';
import 'package:my_board/imports.dart';
import 'package:my_board/core/storage.dart';

class QuantumDeckController extends GetxController with GetSingleTickerProviderStateMixin {
  // Tab Controller
  late TabController tabController;

  // Language
  RxString selectedLanguage = 'ES'.obs;

  // Card of the day
  Rx<QuantumCard?> cardOfTheDay = Rx<QuantumCard?>(null);
  RxBool isDailyCardRevealed = false.obs;

  // All cards and filtering
  RxList<QuantumCard> allCards = <QuantumCard>[].obs;
  RxList<QuantumCard> filteredCards = <QuantumCard>[].obs;
  Rx<ZodiacElement?> selectedElement = Rx<ZodiacElement?>(null);
  RxString selectedSign = ''.obs;

  // Journal entries
  RxList<JournalEntry> journalEntries = <JournalEntry>[].obs;

  // Animation controllers
  RxBool isCardFlipping = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Initialize tab controller
    tabController = TabController(length: 4, vsync: this);

    // Load initial data
    _initializeData();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void _initializeData() async {
    // Load saved language
    final language = await SharedPrefStorage.getString(key: 'quantum_language');
    selectedLanguage.value = language ?? 'ES';

    // Load all cards
    allCards.value = QuantumCard.allCards;
    filteredCards.value = allCards;

    // Load or generate card of the day
    await _loadCardOfTheDay();

    // Load journal entries
    await _loadJournalEntries();
  }

  // =================== CARD OF THE DAY ===================

  Future<void> _loadCardOfTheDay() async {
    final today = DateTime.now();
    final todayKey = 'quantum_daily_card_${today.year}-${today.month}-${today.day}';

    // Try to load saved card for today
    final savedCardId = await SharedPrefStorage.getString(key: todayKey);

    if (savedCardId != null && savedCardId.isNotEmpty) {
      // Find the saved card
      cardOfTheDay.value = allCards.firstWhere(
        (card) => card.id == savedCardId,
        orElse: () => _generateRandomCard(),
      );
      // Check if card was revealed
      final revealedKey = 'quantum_daily_revealed_${today.year}-${today.month}-${today.day}';
      final revealed = await SharedPrefStorage.getBool(key: revealedKey);
      isDailyCardRevealed.value = revealed ?? false;
    } else {
      // Generate new card for today
      cardOfTheDay.value = _generateRandomCard();
      await SharedPrefStorage.storeString(key: todayKey, value: cardOfTheDay.value!.id!);
      isDailyCardRevealed.value = false;
    }
  }

  QuantumCard _generateRandomCard() {
    final random = DateTime.now().millisecondsSinceEpoch % allCards.length;
    return allCards[random];
  }

  Future<void> revealDailyCard() async {
    if (isDailyCardRevealed.value) return;

    isCardFlipping.value = true;

    // Simulate card flip animation delay
    await Future.delayed(const Duration(milliseconds: 800));

    isDailyCardRevealed.value = true;
    isCardFlipping.value = false;

    // Save that card was revealed today
    final today = DateTime.now();
    final revealedKey = 'quantum_daily_revealed_${today.year}-${today.month}-${today.day}';
    await SharedPrefStorage.storeString(key: revealedKey, value: 'true');
  }

  // =================== CARD FILTERING ===================

  void filterByElement(ZodiacElement? element) {
    selectedElement.value = element;
    selectedSign.value = '';
    _applyFilters();
  }

  void filterBySign(String sign) {
    selectedSign.value = sign;
    selectedElement.value = null;
    _applyFilters();
  }

  void clearFilters() {
    selectedElement.value = null;
    selectedSign.value = '';
    _applyFilters();
  }

  void _applyFilters() {
    if (selectedElement.value != null) {
      filteredCards.value = allCards.where((card) =>
        card.element == selectedElement.value).toList();
    } else if (selectedSign.value.isNotEmpty) {
      filteredCards.value = allCards.where((card) =>
        card.zodiacSign == selectedSign.value).toList();
    } else {
      filteredCards.value = allCards;
    }
  }

  // =================== LANGUAGE ===================

  void switchLanguage(String language) {
    selectedLanguage.value = language;
    SharedPrefStorage.storeString(key: 'quantum_language', value: language);
    update();
  }

  String getLocalizedText(String spanish, String english) {
    return selectedLanguage.value == 'ES' ? spanish : english;
  }

  // =================== JOURNAL ===================

  Future<void> _loadJournalEntries() async {
    final entriesJson = await SharedPrefStorage.getString(key: 'quantum_journal_entries');
    if (entriesJson != null && entriesJson.isNotEmpty) {
      try {
        final List<dynamic> entriesList = json.decode(entriesJson);
        journalEntries.value = entriesList.map((e) => JournalEntry.fromJson(e)).toList();
      } catch (e) {
        journalEntries.value = [];
      }
    } else {
      journalEntries.value = [];
    }
  }

  Future<void> addJournalEntry(String cardId, String reflection, String action) async {
    final entry = JournalEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      cardId: cardId,
      date: DateTime.now(),
      reflection: reflection,
      action: action,
    );

    journalEntries.add(entry);
    await _saveJournalEntries();
  }

  Future<void> deleteJournalEntry(String entryId) async {
    journalEntries.removeWhere((entry) => entry.id == entryId);
    await _saveJournalEntries();
  }

  Future<void> _saveJournalEntries() async {
    final entriesJson = json.encode(journalEntries.map((e) => e.toJson()).toList());
    await SharedPrefStorage.storeString(key: 'quantum_journal_entries', value: entriesJson);
  }

  // =================== CARD ACTIONS ===================

  QuantumCard? getRandomCard() {
    if (allCards.isNotEmpty) {
      final random = DateTime.now().millisecondsSinceEpoch % allCards.length;
      return allCards[random];
    }
    return null;
  }

  List<QuantumCard> getCardsByElement(ZodiacElement element) {
    return allCards.where((card) => card.element == element).toList();
  }

  List<QuantumCard> getCardsBySign(String sign) {
    return allCards.where((card) => card.zodiacSign == sign).toList();
  }
}

// Journal Entry Model
class JournalEntry {
  final String id;
  final String cardId;
  final DateTime date;
  final String reflection;
  final String action;

  JournalEntry({
    required this.id,
    required this.cardId,
    required this.date,
    required this.reflection,
    required this.action,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cardId': cardId,
      'date': date.millisecondsSinceEpoch,
      'reflection': reflection,
      'action': action,
    };
  }

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'],
      cardId: json['cardId'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      reflection: json['reflection'],
      action: json['action'],
    );
  }
}