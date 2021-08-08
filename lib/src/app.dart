import 'package:flutter/material.dart';
import 'package:weather_app_clean_architecture/src/presentation/pages/weather_page.dart';

import 'dp.dart';

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DependencyProvider(child: const WeatherPage()),
    );
  }
}
