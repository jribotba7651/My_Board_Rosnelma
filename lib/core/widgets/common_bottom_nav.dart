import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../imports.dart';

class CommonBottomNav extends StatelessWidget {
  final String currentModule;

  const CommonBottomNav({
    Key? key,
    required this.currentModule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.grey[300],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  _buildNavItem(
                    Icons.auto_awesome,
                    'Quantum',
                    currentModule == 'quantum',
                    () {
                      if (currentModule != 'quantum') {
                        Get.toNamed(Routes.quantumDeck);
                      }
                    }
                  ),
                  _buildNavItem(
                    Icons.calendar_today,
                    'Agenda',
                    currentModule == 'agenda',
                    () {
                      if (currentModule != 'agenda') {
                        Get.toNamed(Routes.agendaDigital);
                      }
                    }
                  ),
                  _buildNavItem(
                    Icons.check_circle,
                    'Tasks',
                    currentModule == 'tasks',
                    () {
                      if (currentModule != 'tasks') {
                        Get.toNamed(Routes.taskBoard);
                      }
                    }
                  ),
                  _buildNavItem(
                    Icons.track_changes,
                    'Ikigai',
                    currentModule == 'ikigai',
                    () {
                      if (currentModule != 'ikigai') {
                        Get.toNamed(Routes.lkigaiBoard);
                      }
                    }
                  ),
                  _buildNavItem(
                    Icons.fitness_center,
                    'Power',
                    currentModule == 'power',
                    () {
                      if (currentModule != 'power') {
                        Get.toNamed(Routes.powerMe);
                      }
                    }
                  ),
                  _buildNavItem(
                    Icons.book,
                    'Story',
                    currentModule == 'story',
                    () {
                      if (currentModule != 'story') {
                        Get.toNamed(Routes.storyBoard);
                      }
                    }
                  ),
                  _buildNavItem(
                    Icons.family_restroom,
                    'Family',
                    currentModule == 'family',
                    () {
                      if (currentModule != 'family') {
                        Get.toNamed(Routes.familyTree);
                      }
                    }
                  ),
                  _buildNavItem(
                    Icons.palette,
                    'Visual',
                    currentModule == 'visual',
                    () {
                      if (currentModule != 'visual') {
                        Get.toNamed(Routes.visualBoard);
                      }
                    }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Color(0xFF008B8B) : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Color(0xFF008B8B) : Colors.grey,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? Color(0xFF008B8B) : Colors.grey,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}