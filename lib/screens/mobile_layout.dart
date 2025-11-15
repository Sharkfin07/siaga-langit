import 'package:flutter/material.dart';
import 'package:siaga_langit_0502/widgets/header.dart';
import 'package:siaga_langit_0502/widgets/upcoming.dart';
import 'package:siaga_langit_0502/widgets/weather_box.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            spacing: 20,
            children: [
              Header(),
              Upcoming(),
              Divider(),
              Expanded(
                child: ListView(
                  children: [
                    WeatherBox(
                      city: 'Kota Depok, Jawa Barat',
                      temp: '26',
                      time: '12:00',
                      icon: 'weather_icon.svg',
                      weather: 'Cloudy',
                    ),
                    SizedBox(height: 10),
                    WeatherBox(
                      city: 'Bandung, Jawa Barat',
                      temp: '24',
                      time: '12:00',
                      icon: 'rain_icon.svg',
                      weather: 'Rain',
                    ),
                    SizedBox(height: 10),
                    WeatherBox(
                      city: 'Denpasar, Bali',
                      temp: '28',
                      time: '13:00',
                      icon: 'lightning_icon.svg',
                      weather: 'Thunderstorm',
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
