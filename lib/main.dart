// * Main Inspo https://dribbble.com/shots/18931235-Weather-Forecast-Mobile-app
import 'package:flutter/material.dart';
import 'package:siaga_langit_0502/screens/mobile_layout.dart';
import 'package:siaga_langit_0502/screens/desktop_layout.dart';
import './theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: appTheme, home: const ResponsiveHome());
  }
}

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // ! Sebagai bonus, saya menetapkan 4 buat breakpoint
    if (width >= 1200) {
      return const DesktopLayout(childRatio: 3 / 1.2);
    }
    if (width >= 900) {
      return const DesktopLayout(childRatio: 3 / 1.6);
    }
    if (width >= 600) {
      return const DesktopLayout(childRatio: 3 / 2.5);
    }
    return const MobileLayout();
  }
}
