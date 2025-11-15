import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String iconsPath = '../../assets/icons/';
const double iconsSize = 38;

class Upcoming extends StatelessWidget {
  final MainAxisAlignment alignment;
  final double gap;
  const Upcoming({super.key, required this.alignment, required this.gap});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(opacity: 0.7, child: Text("Lokasi Anda: Tangerang")),
        Row(
          spacing: gap,
          mainAxisAlignment: alignment,
          children: [
            upcomingRowCard(
              icon: "lightning_icon.svg",
              weather: "Storm",
              time: "13:00",
            ),
            upcomingRowCard(
              icon: "rain_icon.svg",
              weather: "Rain",
              time: "14:00",
            ),
            upcomingRowCard(
              icon: "weather_icon.svg",
              weather: "Cloudy",
              time: "15:00",
            ),
          ],
        ),
      ],
    );
  }
}

Widget upcomingRowCard({
  required String icon,
  required String weather,
  required String time,
}) {
  return Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 37, 56, 89),
      borderRadius: BorderRadius.circular(20),
    ),
    width: 100,
    padding: EdgeInsets.all(8),
    child: Column(
      children: [
        SvgPicture.asset(iconsPath + icon, width: iconsSize, height: iconsSize),
        Text(weather),
        Text(
          time,
          style: TextStyle(
            fontSize: 10,
            color: const Color.fromARGB(255, 139, 172, 227),
          ),
        ),
      ],
    ),
  );
}
