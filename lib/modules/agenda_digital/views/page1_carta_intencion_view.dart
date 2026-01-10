import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/agenda_controller.dart';
import '../../../core/widgets/quantum_card_placeholder.dart';

class Page1CartaIntencionView extends StatelessWidget {
  const Page1CartaIntencionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgendaController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SECTION 1: DATE SELECTOR
          _buildDateSelector(controller),
          SizedBox(height: 24),

          // SECTION 2: CARD OF THE DAY
          Obx(() => controller.currentCard.value != null
              ? _buildCardOfTheDay(controller.currentCard.value!)
              : _buildLoadingCard()),
          SizedBox(height: 24),

          // SECTION 3: REFLECTION FIELDS
          _buildReflectionFields(controller),
          SizedBox(height: 24),

          // SECTION 4: SAVE BUTTON
          _buildSaveButton(controller),
        ],
      ),
    );
  }

  // SECTION 1: Date Selector
  Widget _buildDateSelector(AgendaController controller) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: Color(0xFF008B8B)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selected Date',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Obx(() => Text(
                  DateFormat('EEEE, MMMM d, yyyy').format(controller.selectedDate.value),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                )),
              ],
            ),
          ),
          InkWell(
            onTap: () => _showDatePicker(controller),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF008B8B).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Change',
                style: TextStyle(
                  color: Color(0xFF008B8B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Date Picker Dialog
  void _showDatePicker(AgendaController controller) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF008B8B),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.onDateChanged(picked);
    }
  }

  // SECTION 2: Card of the Day
  Widget _buildCardOfTheDay(dynamic card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantum Card of the Day',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Center(
          child: QuantumCardPlaceholder(
            zodiacSign: _extractZodiacSign(card.title),
            zodiacSymbol: _getZodiacSymbol(card.title),
            planet: _extractPlanet(card.title),
            keyword: card.description,
            element: card.category,
            width: 240,
            height: 320,
          ),
        ),
      ],
    );
  }

  // Loading Card Placeholder
  Widget _buildLoadingCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF008B8B)),
          ),
          SizedBox(height: 16),
          Text(
            'Loading card of the day...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // SECTION 3: Reflection Fields
  Widget _buildReflectionFields(AgendaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Reflection',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),

        // Reflection Question 1
        _buildReflectionField(
          controller: controller,
          title: 'How does this card resonate with me?',
          hint: 'Write about how this card speaks to you today...',
          textController: controller.reflection1Controller,
        ),
        SizedBox(height: 16),

        // Reflection Question 2
        _buildReflectionField(
          controller: controller,
          title: 'What specific action will I take?',
          hint: 'Describe the concrete action you will take today...',
          textController: controller.reflection2Controller,
        ),
        SizedBox(height: 16),

        // Reflection Question 3
        _buildReflectionField(
          controller: controller,
          title: 'What intention do I set for today?',
          hint: 'Set a clear intention for your day...',
          textController: controller.reflection3Controller,
        ),
      ],
    );
  }

  Widget _buildReflectionField({
    required AgendaController controller,
    required String title,
    required String hint,
    required TextEditingController textController,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF008B8B),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: textController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // SECTION 4: Save Button
  Widget _buildSaveButton(AgendaController controller) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          controller.saveCardData();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF008B8B),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          'Save Daily Reflection',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Helper methods for astrological card colors and icons
  List<Color> _getCardColors(String category) {
    switch (category.toLowerCase()) {
      case 'fire':
        return [Color(0xFFFF6B35), Color(0xFFFF8E53)]; // Orange-red fire gradient
      case 'earth':
        return [Color(0xFF6B5B95), Color(0xFF88D8C0)]; // Purple-teal earth gradient
      case 'air':
        return [Color(0xFF4ECDC4), Color(0xFF44A08D)]; // Teal-green air gradient
      case 'water':
        return [Color(0xFF667eea), Color(0xFF764ba2)]; // Blue-purple water gradient
      case 'spirit':
        return [Color(0xFFffecd2), Color(0xFFfcb69f)]; // Golden spirit gradient
      default:
        return [Color(0xFF667eea), Color(0xFF764ba2)]; // Default cosmic gradient
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'fire':
        return Icons.local_fire_department; // Fire element
      case 'earth':
        return Icons.terrain; // Earth element
      case 'air':
        return Icons.air; // Air element
      case 'water':
        return Icons.waves; // Water element
      case 'spirit':
        return Icons.auto_awesome; // Spirit/cosmic element
      default:
        return Icons.auto_awesome; // Default cosmic icon
    }
  }

  String _extractZodiacSign(String title) {
    // Extract the first word from title as zodiac sign
    final words = title.split(' ');
    if (words.isNotEmpty) {
      return words.first;
    }
    return 'Aries';
  }

  String _getZodiacSymbol(String title) {
    final sign = _extractZodiacSign(title).toLowerCase();
    switch (sign) {
      case 'aries':
        return '♈';
      case 'taurus':
        return '♉';
      case 'gemini':
        return '♊';
      case 'cancer':
        return '♋';
      case 'leo':
        return '♌';
      case 'virgo':
        return '♍';
      case 'libra':
        return '♎';
      case 'scorpio':
        return '♏';
      case 'sagittarius':
        return '♐';
      case 'capricorn':
        return '♑';
      case 'aquarius':
        return '♒';
      case 'pisces':
        return '♓';
      default:
        return '♈';
    }
  }

  String _extractPlanet(String title) {
    // Extract planet name from title (usually after the zodiac sign)
    final words = title.toLowerCase().split(' ');

    final planets = ['sun', 'moon', 'mercury', 'venus', 'mars', 'jupiter', 'saturn', 'uranus', 'neptune', 'pluto'];

    for (final word in words) {
      if (planets.contains(word)) {
        return word[0].toUpperCase() + word.substring(1);
      }
    }

    // Default planet mapping based on zodiac sign
    final sign = _extractZodiacSign(title).toLowerCase();
    switch (sign) {
      case 'aries':
        return 'Mars';
      case 'taurus':
        return 'Venus';
      case 'gemini':
        return 'Mercury';
      case 'cancer':
        return 'Moon';
      case 'leo':
        return 'Sun';
      case 'virgo':
        return 'Mercury';
      case 'libra':
        return 'Venus';
      case 'scorpio':
        return 'Mars';
      case 'sagittarius':
        return 'Jupiter';
      case 'capricorn':
        return 'Saturn';
      case 'aquarius':
        return 'Uranus';
      case 'pisces':
        return 'Neptune';
      default:
        return 'Sun';
    }
  }
}