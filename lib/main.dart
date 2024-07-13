import 'package:currency_converter_app/utils/navigation_routes.dart';
import 'package:flutter/material.dart';

import 'core/services/dependency_injection.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.kSplashView,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
