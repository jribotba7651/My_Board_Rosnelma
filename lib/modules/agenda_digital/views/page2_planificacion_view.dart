import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/agenda_controller.dart';

class Page2PlanificacionView extends StatelessWidget {
  const Page2PlanificacionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgendaController>();

    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top 3 Priorities
              Text(
                '⭐ TOP 3 PRIORIDADES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008B8B),
                ),
              ),
              SizedBox(height: 15),
              Obx(() => _buildPriorityField(controller, 0)),
              SizedBox(height: 10),
              Obx(() => _buildPriorityField(controller, 1)),
              SizedBox(height: 10),
              Obx(() => _buildPriorityField(controller, 2)),
              
              SizedBox(height: 30),
              
              // Time Blocks
              Text(
                '⏰ BLOQUES DE TIEMPO',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF008B8B),
                ),
              ),
              SizedBox(height: 15),
              
              // Morning
              _buildTimeSection('☀️ MAÑANA', Color(0xFFFF6B35)),
              Obx(() => _buildTimeBlock(controller, '6:00 AM', 0)),
              Obx(() => _buildTimeBlock(controller, '7:00 AM', 1)),
              Obx(() => _buildTimeBlock(controller, '8:00 AM', 2)),
              Obx(() => _buildTimeBlock(controller, '9:00 AM', 3)),
              Obx(() => _buildTimeBlock(controller, '10:00 AM', 4)),
              Obx(() => _buildTimeBlock(controller, '11:00 AM', 5)),
              Obx(() => _buildTimeBlock(controller, '12:00 PM', 6)),
              
              SizedBox(height: 10),
              
              // Afternoon
              _buildTimeSection('🌤️ TARDE', Color(0xFFFFD700)),
              Obx(() => _buildTimeBlock(controller, '1:00 PM', 7)),
              Obx(() => _buildTimeBlock(controller, '2:00 PM', 8)),
              Obx(() => _buildTimeBlock(controller, '3:00 PM', 9)),
              Obx(() => _buildTimeBlock(controller, '4:00 PM', 10)),
              Obx(() => _buildTimeBlock(controller, '5:00 PM', 11)),
              Obx(() => _buildTimeBlock(controller, '6:00 PM', 12)),
              
              SizedBox(height: 10),
              
              // Evening
              _buildTimeSection('🌙 NOCHE', Color(0xFF4169E1)),
              Obx(() => _buildTimeBlock(controller, '7:00 PM', 13)),
              Obx(() => _buildTimeBlock(controller, '8:00 PM', 14)),
              Obx(() => _buildTimeBlock(controller, '9:00 PM', 15)),
              Obx(() => _buildTimeBlock(controller, '10:00 PM', 16)),
              Obx(() => _buildTimeBlock(controller, '11:00 PM', 17)),
              
              SizedBox(height: 30),
              
              // Trackers
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '💧 AGUA (8 vasos)',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        Obx(() => Wrap(
                          spacing: 8,
                          children: List.generate(8, (index) {
                            return GestureDetector(
                              onTap: () {
                                controller.waterGlasses[index].value = !controller.waterGlasses[index].value;
                              },
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(0xFF4169E1),
                                    width: 2,
                                  ),
                                  color: controller.waterGlasses[index].value
                                      ? Color(0xFF4169E1)
                                      : Colors.transparent,
                                ),
                                child: controller.waterGlasses[index].value
                                    ? Icon(Icons.check, size: 16, color: Colors.white)
                                    : null,
                              ),
                            );
                          }),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '🍽️ COMIDAS',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        Obx(() => _buildMealField(controller, 'D', 0)),
                        SizedBox(height: 5),
                        Obx(() => _buildMealField(controller, 'A', 1)),
                        SizedBox(height: 5),
                        Obx(() => _buildMealField(controller, 'C', 2)),
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 30),
              
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.savePage2();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF008B8B),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Guardar Planificación',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityField(AgendaController controller, int index) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Color(0xFF008B8B),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller.priorityControllers[index],
            decoration: InputDecoration(
              hintText: 'Prioridad ${index + 1}',
              hintStyle: TextStyle(color: Colors.grey[400]),
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
                borderSide: BorderSide(color: Color(0xFF008B8B), width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSection(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildTimeBlock(AgendaController controller, String time, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              time,
              style: TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller.timeBlockControllers[index],
              decoration: InputDecoration(
                hintText: 'Actividad',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF008B8B)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealField(AgendaController controller, String label, int index) {
    return Row(
      children: [
        Text(
          '$label:',
          style: TextStyle(fontSize: 13, color: Colors.black87),
        ),
        SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller.mealControllers[index],
            decoration: InputDecoration(
              hintText: '...',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF008B8B)),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              isDense: true,
            ),
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
