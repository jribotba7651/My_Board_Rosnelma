// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:my_board/data/models/quantum_card_model.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/quantum%20deck/quantum_deck_controller.dart';
import '../../../../imports.dart';

class QuantumDeckView extends GetView<QuantumDeckController> {
  const QuantumDeckView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  _buildTodayTab(),
                  _buildDeckTab(),
                  _buildJournalTab(),
                  _buildSettingsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      child: Row(
        children: [
          InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back_ios),
          ),
          SizedBox(width: Get.width * 0.2),
          Text(
            "Quantum Deck",
            style: TextStyles.text3?.copyWith(
              color: const Color(0xFF008B8B), // Teal color
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: const Color(0xFF008B8B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Obx(() => Text(
              "🔮 ${controller.selectedLanguage.value}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF008B8B),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TabBar(
        controller: controller.tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF008B8B),
          borderRadius: BorderRadius.circular(25.0),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        tabs: [
          Tab(text: "Hoy"),
          Tab(text: "Deck"),
          Tab(text: "Diario"),
          Tab(text: "Ajustes"),
        ],
      ),
    );
  }

  // ================== TODAY TAB ==================
  Widget _buildTodayTab() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            "Carta del Día",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF008B8B),
            ),
          ),
          SizedBox(height: 10),
          Text(
            _getTodayMessage(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Center(
              child: Obx(() => _buildDailyCard()),
            ),
          ),
          SizedBox(height: 20),
          Obx(() => controller.cardOfTheDay.value != null && controller.isDailyCardRevealed.value
            ? _buildCardDetails(controller.cardOfTheDay.value!)
            : SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyCard() {
    if (controller.cardOfTheDay.value == null) {
      return CircularProgressIndicator();
    }

    return GestureDetector(
      onTap: () => controller.revealDailyCard(),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 600),
        width: 200,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 15.0,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: controller.isDailyCardRevealed.value
          ? _buildRevealedCard(controller.cardOfTheDay.value!)
          : _buildHiddenCard(),
      ),
    );
  }

  Widget _buildHiddenCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF008B8B),
            const Color(0xFF006666),
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "🔮",
              style: TextStyle(fontSize: 50),
            ),
            SizedBox(height: 10),
            Text(
              "QUANTUM",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            Text(
              "DECK",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Toca para revelar",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevealedCard(QuantumCard card) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            card.elementColor,
            card.elementColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  card.elementEmoji,
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  card.symbol ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              card.zodiacSign ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Obx(() => Text(
              controller.getLocalizedText(
                card.actionES ?? '',
                card.actionEN ?? '',
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w300,
              ),
            )),
            Spacer(),
            Obx(() => Wrap(
              children: (controller.selectedLanguage.value == 'ES'
                  ? card.keywordsES ?? []
                  : card.keywordsEN ?? [])
                .map((keyword) => Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    keyword,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                )).toList(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildCardDetails(QuantumCard card) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Afirmación",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: card.elementColor,
            ),
          ),
          SizedBox(height: 10),
          Obx(() => Text(
            controller.getLocalizedText(
              card.affirmationES ?? '',
              card.affirmationEN ?? '',
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontStyle: FontStyle.italic,
            ),
          )),
        ],
      ),
    );
  }

  // ================== DECK TAB ==================
  Widget _buildDeckTab() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          _buildFilterBar(),
          SizedBox(height: 15),
          Expanded(
            child: Obx(() => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: controller.filteredCards.length,
              itemBuilder: (context, index) {
                return _buildCardTile(controller.filteredCards[index]);
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Column(
      children: [
        // Element filters
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildFilterChip('🔥', ZodiacElement.fire, const Color(0xFFFF6B35)),
            _buildFilterChip('🌍', ZodiacElement.earth, const Color(0xFF8B4513)),
            _buildFilterChip('💨', ZodiacElement.air, const Color(0xFF87CEEB)),
            _buildFilterChip('💧', ZodiacElement.water, const Color(0xFF4169E1)),
          ],
        ),
        SizedBox(height: 10),
        // Clear filters button
        Obx(() => controller.selectedElement.value != null || controller.selectedSign.value.isNotEmpty
          ? TextButton(
              onPressed: controller.clearFilters,
              child: Text("Limpiar filtros", style: TextStyle(color: const Color(0xFF008B8B))),
            )
          : SizedBox(),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String emoji, ZodiacElement element, Color color) {
    return Obx(() => GestureDetector(
      onTap: () => controller.filterByElement(
        controller.selectedElement.value == element ? null : element
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: controller.selectedElement.value == element
            ? color.withOpacity(0.2)
            : Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: controller.selectedElement.value == element
              ? color
              : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(emoji, style: TextStyle(fontSize: 20)),
      ),
    ));
  }

  Widget _buildCardTile(QuantumCard card) {
    return GestureDetector(
      onTap: () => _showCardDetail(card),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              card.elementColor,
              card.elementColor.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: card.elementColor.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(card.elementEmoji, style: TextStyle(fontSize: 20)),
                  Text(
                    card.symbol ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                card.zodiacSign ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Obx(() => Text(
                controller.getLocalizedText(
                  card.actionES ?? '',
                  card.actionEN ?? '',
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              )),
              Spacer(),
              Obx(() => Text(
                (controller.selectedLanguage.value == 'ES'
                    ? card.keywordsES ?? []
                    : card.keywordsEN ?? []).take(2).join(' • '),
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
        ),
      ),
    );
  }

  // ================== JOURNAL TAB ==================
  Widget _buildJournalTab() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Reflexiones",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF008B8B),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: _showAddJournalEntry,
                icon: Icon(
                  Icons.add_circle,
                  color: const Color(0xFF008B8B),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Expanded(
            child: Obx(() => controller.journalEntries.isEmpty
              ? _buildEmptyJournal()
              : ListView.builder(
                  itemCount: controller.journalEntries.length,
                  itemBuilder: (context, index) {
                    return _buildJournalEntry(controller.journalEntries[index]);
                  },
                ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyJournal() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "📝",
            style: TextStyle(fontSize: 50),
          ),
          SizedBox(height: 20),
          Text(
            "Sin reflexiones aún",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Agrega tus pensamientos y acciones",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildJournalEntry(JournalEntry entry) {
    final card = controller.allCards.firstWhere(
      (c) => c.id == entry.cardId,
      orElse: () => controller.allCards.first,
    );

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: card.elementColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "${card.elementEmoji} ${card.zodiacSign}",
                  style: TextStyle(
                    color: card.elementColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Text(
                "${entry.date.day}/${entry.date.month}/${entry.date.year}",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
              IconButton(
                onPressed: () => controller.deleteJournalEntry(entry.id),
                icon: Icon(Icons.delete, color: Colors.red[300], size: 20),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            entry.reflection,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          if (entry.action.isNotEmpty) ...[
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "Acción: ${entry.action}",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ================== SETTINGS TAB ==================
  Widget _buildSettingsTab() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Configuración",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF008B8B),
            ),
          ),
          SizedBox(height: 30),
          _buildSettingCard(
            "Idioma",
            "Selecciona tu idioma preferido",
            Icons.language,
            _buildLanguageSelector(),
          ),
          SizedBox(height: 20),
          _buildSettingCard(
            "Acerca de Quantum Deck",
            "Sistema de 40 cartas astrológicas",
            Icons.info_outline,
            _buildAboutInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard(String title, String subtitle, IconData icon, Widget content) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF008B8B)),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          content,
        ],
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Row(
      children: [
        Obx(() => _buildLanguageOption("Español", "ES")),
        SizedBox(width: 20),
        Obx(() => _buildLanguageOption("English", "EN")),
      ],
    );
  }

  Widget _buildLanguageOption(String language, String code) {
    final isSelected = controller.selectedLanguage.value == code;

    return GestureDetector(
      onTap: () => controller.switchLanguage(code),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF008B8B) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          language,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildAboutInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow("🔥 Fuego", "9 cartas - Aries, Leo, Sagitario"),
        _buildInfoRow("🌍 Tierra", "9 cartas - Tauro, Virgo, Capricornio"),
        _buildInfoRow("💨 Aire", "9 cartas - Géminis, Libra, Acuario"),
        _buildInfoRow("💧 Agua", "9 cartas - Cáncer, Escorpio, Piscis"),
        SizedBox(height: 10),
        Text(
          "Total: 40 cartas con acciones ejecutivas, keywords y afirmaciones en español e inglés.",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================== HELPER METHODS ==================
  String _getTodayMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Buenos días. Tu carta de hoy te espera.";
    } else if (hour < 18) {
      return "Buenas tardes. Descubre tu guía del día.";
    } else {
      return "Buenas noches. Reflexiona con tu carta.";
    }
  }

  void _showCardDetail(QuantumCard card) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 200,
                height: 280,
                child: _buildRevealedCard(card),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildCardDetails(card),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddJournalEntry() {
    final reflectionController = TextEditingController();
    final actionController = TextEditingController();

    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Nueva Reflexión",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF008B8B),
                ),
              ),
              SizedBox(height: 20),
              Text("Reflexión", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              TextField(
                controller: reflectionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "¿Qué reflexión tienes hoy?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text("Acción (opcional)", style: TextStyle(fontWeight: FontWeight.w600)),
              SizedBox(height: 8),
              TextField(
                controller: actionController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: "¿Qué acción tomarás?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (reflectionController.text.isNotEmpty) {
                      controller.addJournalEntry(
                        controller.cardOfTheDay.value?.id ?? '',
                        reflectionController.text,
                        actionController.text,
                      );
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF008B8B),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Guardar Reflexión",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}