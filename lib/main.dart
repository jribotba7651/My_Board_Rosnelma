// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/services.dart';
import 'package:my_board/imports.dart';
import 'routes/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Board',
      theme: AppTheme.lightTheme,
      initialRoute: Routes.initialSplash,
      getPages: AppPages.pages,
      initialBinding: Binding(),
     // home: MyFamilyApp(),
    );
  }
}



 