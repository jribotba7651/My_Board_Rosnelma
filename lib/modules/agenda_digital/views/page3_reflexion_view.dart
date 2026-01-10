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
          Text(
            'Page 3: Reflection',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text('Day rating will go here'),
          SizedBox(height: 20),
          Text('And evening reflection'),
        ],
      ),
    );
  }
}