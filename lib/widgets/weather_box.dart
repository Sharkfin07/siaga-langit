import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const double weatherIconSize = 110;
const String iconPath = "../../assets/icons/";

// ignore: must_be_immutable
class WeatherBox extends StatelessWidget {
  late String city, temp, weather, icon, time;
  WeatherBox({
    super.key,
    required this.city,
    required this.temp,
    required this.time,
    required this.icon,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 31, 126, 204),
      ),
      // height: 300,
      child: Column(
        spacing: 10,
        children: [
          Opacity(
            opacity: 0.7,
            child: Text(
              city,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 183, 215, 228),
                    ),
                  ),
                  Text(
                    "$temp° C",
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    weather,
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 183, 215, 228),
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                iconPath + icon,
                width: weatherIconSize,
                height: weatherIconSize,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              weatherDetailRow(title: "AQI", value: "20"),
              weatherDetailSeperator(),
              weatherDetailRow(title: "Wind", value: "14 km/h"),
              weatherDetailSeperator(),
              weatherDetailRow(title: "Humidity", value: "90%"),
            ],
          ),
        ],
      ),
    );
  }
}

Widget weatherDetailRow({required String title, required String value}) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w100,
          color: const Color.fromARGB(255, 183, 215, 228),
        ),
      ),
      Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    ],
  );
}

Widget weatherDetailSeperator() {
  return Container(
    width: 1,
    height: 38,
    color: const Color.fromARGB(255, 183, 215, 228),
  );
}
