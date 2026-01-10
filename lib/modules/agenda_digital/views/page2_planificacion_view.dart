import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/agenda_controller.dart';

class Page2PlanificacionView extends StatelessWidget {
  const Page2PlanificacionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgendaController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SECTION 1: TOP 3 PRIORITIES
          _buildPrioritiesSection(controller),

          SizedBox(height: 32),

          // SECTION 2: TIME BLOCKS
          _buildTimeBlocksSection(controller),

          SizedBox(height: 32),

          // SECTION 3: TRACKERS
          _buildTrackersSection(controller),

          SizedBox(height: 32),

          // SECTION 4: SAVE BUTTON
          _buildSaveButton(controller),

          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPrioritiesSection(AgendaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star, color: Color(0xFF008B8B), size: 28),
            SizedBox(width: 8),
            Text(
              'Top 3 Priorities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        _buildPriorityField(1, 'Most important task for today', controller.prioridad1),
        SizedBox(height: 12),
        _buildPriorityField(2, 'Second priority', controller.prioridad2),
        SizedBox(height: 12),
        _buildPriorityField(3, 'Third priority', controller.prioridad3),
      ],
    );
  }

  Widget _buildPriorityField(int number, String hint, RxString observable) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Color(0xFF008B8B),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$number',
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
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) => observable.value = value,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeBlocksSection(AgendaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, color: Color(0xFF008B8B), size: 28),
            SizedBox(width: 8),
            Text(
              'Time Blocks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // MORNING (6am-12pm) - 7 blocks
        _buildTimeBlockGroup(
          '☀️ MORNING',
          Color(0xFFFF6B35),
          6,
          7,
          controller,
        ),

        SizedBox(height: 16),

        // AFTERNOON (1pm-6pm) - 6 blocks
        _buildTimeBlockGroup(
          '🌤️ AFTERNOON',
          Color(0xFFFFD700),
          13,
          6,
          controller,
        ),

        SizedBox(height: 16),

        // EVENING (7pm-11pm) - 5 blocks
        _buildTimeBlockGroup(
          '🌙 EVENING',
          Color(0xFF4169E1),
          19,
          5,
          controller,
        ),
      ],
    );
  }

  Widget _buildTimeBlockGroup(String title, Color color, int startHour, int count, AgendaController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 8),
        ...List.generate(count, (index) {
          int hour = startHour + index;
          String displayHour;

          if (hour < 12) {
            displayHour = '${hour}:00 AM';
          } else if (hour == 12) {
            displayHour = '12:00 PM';
          } else {
            displayHour = '${hour - 12}:00 PM';
          }

          int blockIndex = hour - 6; // 6am = index 0

          return Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    displayHour,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Activity',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                    onChanged: (value) => controller.timeBlocks[blockIndex].value = value,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTrackersSection(AgendaController controller) {
    return Column(
      children: [
        // WATER TRACKER
        Row(
          children: [
            Icon(Icons.water_drop, color: Color(0xFF4169E1), size: 24),
            SizedBox(width: 8),
            Text(
              'Water Tracker (8 glasses)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(8, (index) {
            return Obx(() => GestureDetector(
              onTap: () {
                controller.waterGlasses[index] = !controller.waterGlasses[index];
                controller.waterGlasses.refresh();
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFF4169E1),
                    width: 2,
                  ),
                  color: controller.waterGlasses[index]
                      ? Color(0xFF4169E1)
                      : Colors.transparent,
                ),
                child: controller.waterGlasses[index]
                    ? Icon(
                        Icons.water_drop,
                        color: Colors.white,
                        size: 20,
                      )
                    : null,
              ),
            ));
          }),
        ),

        SizedBox(height: 24),

        // MEALS TRACKER
        Row(
          children: [
            Icon(Icons.restaurant, color: Color(0xFF008B8B), size: 24),
            SizedBox(width: 8),
            Text(
              'Meals Tracker',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '🌅 Breakfast',
                  labelStyle: TextStyle(color: Color(0xFF008B8B)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF008B8B)),
                  ),
                  contentPadding: EdgeInsets.all(12),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => controller.breakfast.value = value,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '☀️ Lunch',
                  labelStyle: TextStyle(color: Color(0xFF008B8B)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF008B8B)),
                  ),
                  contentPadding: EdgeInsets.all(12),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => controller.lunch.value = value,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '🌙 Dinner',
                  labelStyle: TextStyle(color: Color(0xFF008B8B)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF008B8B)),
                  ),
                  contentPadding: EdgeInsets.all(12),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => controller.dinner.value = value,
              ),
            ),
          ],
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
            'Daily planning saved successfully!',
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
          'Save Daily Planning',
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