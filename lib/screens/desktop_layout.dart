import 'package:flutter/material.dart';
import 'package:siaga_langit_0502/widgets/header.dart';
import 'package:siaga_langit_0502/widgets/upcoming.dart';
import 'package:siaga_langit_0502/widgets/weather_box.dart';

class DesktopLayout extends StatelessWidget {
  final double childRatio;
  const DesktopLayout({super.key, required this.childRatio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 30,
            children: [
              Header(),
              Upcoming(alignment: MainAxisAlignment.start, gap: 20),
              Divider(),
              Expanded(
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: childRatio,
                  children: [
                    WeatherBox(
                      city: 'Kota Depok, Jawa Barat',
                      temp: '26',
                      time: '12:00',
                      icon: 'weather_icon.svg',
                      weather: 'Cloudy',
                    ),
                    WeatherBox(
                      city: 'Bandung, Jawa Barat',
                      temp: '24',
                      time: '12:00',
                      icon: 'rain_icon.svg',
                      weather: 'Rain',
                    ),
                    WeatherBox(
                      city: 'Denpasar, Bali',
                      temp: '28',
                      time: '13:00',
                      icon: 'lightning_icon.svg',
                      weather: 'Thunderstorm',
                    ),
                    WeatherBox(
                      city: 'Jakarta',
                      temp: '12',
                      time: '12:00',
                      icon: 'flood_icon.svg',
                      weather: 'Tenggelam',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
