import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/agenda_controller.dart';

class Page3ReflexionView extends StatelessWidget {
  const Page3ReflexionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgendaController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DAY RATING SECTION
          _buildDayRatingSection(controller),

          SizedBox(height: 32),

          // EVENING CHECK-IN
          _buildEveningCheckinSection(controller),

          SizedBox(height: 32),

          // CARD MANIFESTATION
          _buildCardManifestationSection(controller),

          SizedBox(height: 32),

          // WINS OF THE DAY
          _buildWinsSection(controller),

          SizedBox(height: 32),

          // LESSONS LEARNED
          _buildLessonsSection(controller),

          SizedBox(height: 32),

          // FREE NOTES
          _buildFreeNotesSection(controller),

          SizedBox(height: 32),

          // GRATITUDE
          _buildGratitudeSection(controller),

          SizedBox(height: 32),

          // SAVE BUTTON
          _buildSaveButton(controller),

          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDayRatingSection(AgendaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star, color: Color(0xFF008B8B), size: 28),
            SizedBox(width: 8),
            Text(
              'Day Rating',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'How would you rate your day overall?',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 16),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(10, (index) {
            final rating = index + 1;
            final isSelected = controller.rating.value == rating;

            return GestureDetector(
              onTap: () => controller.rating.value = rating,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Color(0xFF008B8B) : Colors.transparent,
                  border: Border.all(
                    color: Color(0xFF008B8B),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$rating',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Color(0xFF008B8B),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }),
        )),
      ],
    );
  }

  Widget _buildEveningCheckinSection(AgendaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFF008B8B), size: 28),
            SizedBox(width: 8),
            Text(
              'Evening Check-in',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        _buildCheckboxItem(
          'Did I complete my priorities?',
          controller.completedPriorities,
        ),
        SizedBox(height: 12),

        _buildCheckboxItem(
          'Did I practice self-care?',
          controller.practicedSelfCare,
        ),
        SizedBox(height: 12),

        _buildCheckboxItem(
          'Did I connect with others?',
          controller.connectedWithOthers,
        ),
        SizedBox(height: 12),

        _buildCheckboxItem(
          'Did I honor my energy?',
          controller.honoredEnergy,
        ),
      ],
    );
  }

  Widget _buildCheckboxItem(String title, RxBool observable) {
    return Obx(() => Row(
      children: [
        Checkbox(
          value: observable.value,
          onChanged: (value) => observable.value = value ?? false,
          activeColor: Color(0xFF008B8B),
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildCardManifestationSection(AgendaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, color: Color(0xFF008B8B), size: 28),
            SizedBox(width: 8),
            Text(
              'Card Manifestation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'How did today\'s card manifest in your life?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF008B8B), width: 2),
            ),
            contentPadding: EdgeInsets.all(16),
            filled: true,
            fillColor: Colors.white,
          ),
          maxLines: 3,
          onChanged: (value) => controller.cardManifestation.value = value,
        ),
      ],
    );
  }

  Widget _buildWinsSection(AgendaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.celebration, color: Color(0xFF008B8B), size: 28),
            SizedBox(width: 8),
            Text(
              'Wins of the Day',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        _buildWinField(1, 'First win of the day', controller.win1),
        SizedBox(height: 12),
        _buildWinField(2, 'Second win of the day', controller.win2),
        SizedBox(height: 12),
        _buildWinField(3, 'Third win of the day', controller.win3),
      ],
    );
  }

  Widget _buildWinField(int number, String hint, RxString observable) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Color(0xFF008B8B),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '•',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFF008B8B)),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            onChanged: (value) => observable.value = value,
          ),
        ),
      ],
    );
  }

  Widget _buildLessonsSection(AgendaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.school, color: Color(0xFF008B8B), size: 28),
            SizedBox(width: 8),
            Text(
              'Lessons Learned',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'What did you learn today?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF008B8B), width: 2),
            ),
            contentPadding: EdgeInsets.all(16),
            filled: true,
            fillColor: Colors.white,
          ),
          maxLines: 2,
          onChanged: (value) => controller.lessonsLearned.value = value,
        ),
      ],
    );
  }

  Widget _buildFreeNotesSection(AgendaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.notes, color: Color(0xFF008B8B), size: 28),
            SizedBox(width: 8),
            Text(
              'Free Notes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Any additional thoughts or reflections...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF008B8B), width: 2),
            ),
            contentPadding: EdgeInsets.all(16),
            filled: true,
            fillColor: Colors.white,
          ),
          maxLines: 6,
          onChanged: (value) => controller.freeNotes.value = value,
        ),
      ],
    );
  }

  Widget _buildGratitudeSection(AgendaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.favorite, color: Color(0xFF008B8B), size: 28),
            SizedBox(width: 8),
            Text(
              'Gratitude',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'What are you grateful for today?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF008B8B), width: 2),
            ),
            contentPadding: EdgeInsets.all(16),
            filled: true,
            fillColor: Colors.white,
          ),
          maxLines: 2,
          onChanged: (value) => controller.gratitude.value = value,
        ),
      ],
    );
  }

  Widget _buildSaveButton(AgendaController controller) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          controller.guardarEntrada();
          Get.snackbar(
            'Success',
            'Complete day saved successfully!',
            backgroundColor: Color(0xFF008B8B),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF008B8B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          'Save Complete Day',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}