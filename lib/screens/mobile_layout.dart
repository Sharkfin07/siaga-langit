import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siaga_langit_0502/widgets/header.dart';
import 'package:siaga_langit_0502/widgets/upcoming.dart';
import 'package:siaga_langit_0502/widgets/weather_box.dart';

class CityWeather {
  final String city;
  final String temp;
  final String time;
  final String icon;
  final String weather;

  const CityWeather({
    required this.city,
    required this.temp,
    required this.time,
    required this.icon,
    required this.weather,
  });
}

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _currentIndex = 0;

  static const List<CityWeather> _homeCities = [
    CityWeather(
      city: 'Kota Depok, Jawa Barat',
      temp: '26',
      time: '12:00',
      icon: 'weather_icon.svg',
      weather: 'Cloudy',
    ),
    CityWeather(
      city: 'Bandung, Jawa Barat',
      temp: '24',
      time: '12:00',
      icon: 'rain_icon.svg',
      weather: 'Rain',
    ),
    CityWeather(
      city: 'Denpasar, Bali',
      temp: '28',
      time: '13:00',
      icon: 'lightning_icon.svg',
      weather: 'Thunderstorm',
    ),
    CityWeather(
      city: 'Jakarta',
      temp: '12',
      time: '12:00',
      icon: 'flood_icon.svg',
      weather: 'Tenggelam',
    ),
  ];

  static const List<CityWeather> _worldCities = [
    CityWeather(
      city: 'New York City, USA',
      temp: '18',
      time: '07:45',
      icon: 'weather_icon.svg',
      weather: 'Cloudy',
    ),
    CityWeather(
      city: 'London, United Kingdom',
      temp: '12',
      time: '12:45',
      icon: 'rain_icon.svg',
      weather: 'Light Rain',
    ),
    CityWeather(
      city: 'Tokyo, Japan',
      temp: '22',
      time: '21:45',
      icon: 'lightning_icon.svg',
      weather: 'Stormy',
    ),
    CityWeather(
      city: 'Sydney, Australia',
      temp: '26',
      time: '23:45',
      icon: 'weather_icon.svg',
      weather: 'Sunny',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomePage(
        cities: _homeCities,
        onCitySelected: (city) => _openWorldDetail(context, city),
      ),
      _WorldPage(worldCities: _worldCities),
      const _ClockPage(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'World'),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Clock',
          ),
        ],
      ),
    );
  }

  void _openWorldDetail(BuildContext context, CityWeather city) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            WorldDetailPage(cityFromHome: city, worldCities: _worldCities),
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  final List<CityWeather> cities;
  final ValueChanged<CityWeather> onCitySelected;

  const _HomePage({required this.cities, required this.onCitySelected});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const Header(subtitle: 'Apa kabar, Indonesia?'),
        const SizedBox(height: 20),
        const Upcoming(alignment: MainAxisAlignment.spaceBetween, gap: 0),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        Opacity(
          opacity: 0.7,
          child: Text(
            'Tip: Tekan salah satu kota untuk membandingkan cuacanya dengan cuaca dunia.',
          ),
        ),
        const SizedBox(height: 20),
        ...cities.map(
          (city) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () => onCitySelected(city),
              child: WeatherBox(
                city: city.city,
                temp: city.temp,
                time: city.time,
                icon: city.icon,
                weather: city.weather,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WorldPage extends StatelessWidget {
  final List<CityWeather> worldCities;

  const _WorldPage({required this.worldCities});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Header(subtitle: 'What is up, World?'),
        SvgPicture.asset(
          '../../assets/icons/map_icon.svg',
          width: 500,
          height: 300,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const Divider(),
        const SizedBox(height: 20),
        const Text(
          'Cuaca Dunia',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        ...worldCities.map(
          (city) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: WeatherBox(
              city: city.city,
              temp: city.temp,
              time: city.time,
              icon: city.icon,
              weather: city.weather,
            ),
          ),
        ),
      ],
    );
  }
}

class _ClockPage extends StatelessWidget {
  const _ClockPage();

  static const _dummyTimes = [
    {'city': 'Jakarta (WIB)', 'time': '12:45', 'date': 'Rabu, 15 Nov'},
    {'city': 'Tokyo (JST)', 'time': '14:45', 'date': 'Rabu, 15 Nov'},
    {'city': 'London (GMT)', 'time': '06:45', 'date': 'Rabu, 15 Nov'},
    {'city': 'New York (EST)', 'time': '01:45', 'date': 'Rabu, 15 Nov'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Clock Overview',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPrimaryCard(),
          const SizedBox(height: 24),
          const Text(
            'World Time',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _dummyTimes.length,
              itemBuilder: (context, index) {
                final data = _dummyTimes[index];
                return _ClockTile(
                  city: data['city']!,
                  time: data['time']!,
                  date: data['date']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.blueGrey.shade900,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Jakarta, Indonesia', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 10),
          Text(
            '12:45',
            style: TextStyle(
              color: Colors.white,
              fontSize: 56,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Rabu, 15 November 2025',
            style: TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}

class _ClockTile extends StatelessWidget {
  final String city;
  final String time;
  final String date;

  const _ClockTile({
    required this.city,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(date, style: const TextStyle(color: Colors.white60)),
            ],
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class WorldDetailPage extends StatelessWidget {
  final CityWeather cityFromHome;
  final List<CityWeather> worldCities;

  const WorldDetailPage({
    super.key,
    required this.cityFromHome,
    required this.worldCities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perbandingan Cuaca',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Cuaca Kamu',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          WeatherBox(
            city: cityFromHome.city,
            temp: cityFromHome.temp,
            time: cityFromHome.time,
            icon: cityFromHome.icon,
            weather: cityFromHome.weather,
          ),
          const SizedBox(height: 24),
          const Text(
            'Cuaca Dunia Lainnya',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...worldCities.map(
            (city) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: WeatherBox(
                city: city.city,
                temp: city.temp,
                time: city.time,
                icon: city.icon,
                weather: city.weather,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
