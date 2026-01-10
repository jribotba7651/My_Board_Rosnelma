import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../imports.dart';
import '../controllers/agenda_controller.dart';
import 'page1_carta_intencion_view.dart';
import 'page2_planificacion_view.dart';
import 'page3_reflexion_view.dart';

class AgendaMainView extends StatelessWidget {
  const AgendaMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AgendaController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Digital Agenda'),
          backgroundColor: const Color(0xFF008B8B), // Teal
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.auto_awesome), text: 'Card'),
              Tab(icon: Icon(Icons.schedule), text: 'Planning'),
              Tab(icon: Icon(Icons.nightlight_round), text: 'Reflection'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Page1CartaIntencionView(),
            Page2PlanificacionView(),
            Page3ReflexionView(),
          ],
        ),
        bottomNavigationBar: CommonBottomNav(currentModule: 'agenda'),
      ),
    );
  }
}