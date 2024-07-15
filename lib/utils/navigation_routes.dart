import 'package:currency_converter_app/features/presentation/views/exchanger/exchanger_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../features/presentation/views/splash/splash_screen.dart';

class Routes {
  static const String kSplashView = "kSplashView";
  static const String kExchangerView = "kExchangerView";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.kSplashView:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kSplashView),
        );
      case Routes.kExchangerView:
        return PageTransition(
          child: const ExchangerScreen(),
          type: PageTransitionType.fade,
          settings: const RouteSettings(name: Routes.kExchangerView),
        );
      default:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const Scaffold(
            body: Center(
              child: Text("Invalid Route"),
            ),
          ),
        );
    }
  }
}
