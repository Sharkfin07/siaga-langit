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

class DesktopLayout extends StatefulWidget {
  final double childRatio;
  const DesktopLayout({super.key, required this.childRatio});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  int _selectedIndex = 0;

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
      _DesktopHomePage(
        cities: _homeCities,
        childRatio: widget.childRatio,
        onCitySelected: (city) => _openWorldDetail(context, city),
      ),
      _DesktopWorldPage(worldCities: _worldCities),
      const _DesktopClockPage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              backgroundColor: const Color(0xFF0B1220),
              selectedIconTheme: const IconThemeData(color: Colors.blue),
              unselectedIconTheme: IconThemeData(color: Colors.white70),
              selectedLabelTextStyle: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) =>
                  setState(() => _selectedIndex = index),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.public_outlined),
                  selectedIcon: Icon(Icons.public),
                  label: Text('World'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.access_time_outlined),
                  selectedIcon: Icon(Icons.access_time),
                  label: Text('Clock'),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: pages[_selectedIndex],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openWorldDetail(BuildContext context, CityWeather city) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _DesktopWorldDetailPage(
          cityFromHome: city,
          worldCities: _worldCities,
        ),
      ),
    );
  }
}

class _DesktopHomePage extends StatelessWidget {
  final List<CityWeather> cities;
  final double childRatio;
  final ValueChanged<CityWeather> onCitySelected;

  const _DesktopHomePage({
    required this.cities,
    required this.childRatio,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Header(subtitle: 'Apa kabar, Indonesia?'),
          const SizedBox(height: 20),
          const Upcoming(alignment: MainAxisAlignment.start, gap: 20),
          const Divider(),
          const SizedBox(height: 16),
          Opacity(
            opacity: 0.7,
            child: Text(
              'Klik salah satu kota untuk melihat perbandingan dengan cuaca dunia.',
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: cities.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: childRatio,
              ),
              itemBuilder: (context, index) {
                final city = cities[index];
                return GestureDetector(
                  onTap: () => onCitySelected(city),
                  child: WeatherBox(
                    city: city.city,
                    temp: city.temp,
                    time: city.time,
                    icon: city.icon,
                    weather: city.weather,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopWorldPage extends StatelessWidget {
  final List<CityWeather> worldCities;

  const _DesktopWorldPage({required this.worldCities});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Header(subtitle: 'What is up, World?'),
        const SizedBox(height: 16),
        SvgPicture.asset(
          '../../assets/icons/map_icon.svg',
          height: 320,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        const Divider(),
        const SizedBox(height: 16),
        const Text(
          'Cuaca Dunia',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
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
    );
  }
}

class _DesktopClockPage extends StatelessWidget {
  const _DesktopClockPage();

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
            'Clock Overview (Dummy)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPrimaryCard(),
          const SizedBox(height: 24),
          const Text(
            'World Time (Dummy)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _dummyTimes.length,
              itemBuilder: (context, index) {
                final data = _dummyTimes[index];
                return _DesktopClockTile(
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
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.blueGrey.shade900,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Jakarta, Indonesia', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 12),
          Text(
            '12:45',
            style: TextStyle(
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Rabu, 15 November 2025',
            style: TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}

class _DesktopClockTile extends StatelessWidget {
  final String city;
  final String time;
  final String date;

  const _DesktopClockTile({
    required this.city,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
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
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopWorldDetailPage extends StatelessWidget {
  final CityWeather cityFromHome;
  final List<CityWeather> worldCities;

  const _DesktopWorldDetailPage({
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
            'Dikirim dari Home',
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
