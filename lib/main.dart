// * Main Inspo https://dribbble.com/shots/18931235-Weather-Forecast-Mobile-app
import 'package:flutter/material.dart';
import 'package:siaga_langit_0502/screens/mobile_layout.dart';
import './theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: appTheme, home: MobileLayout());
  }
}
