# Assignment Navigation
## Pertanyaan Refleksi

**1) Dari proses membuat navigasi multi halaman pada Weather App, bagaimana kamu memastikan alur berpindah halaman tetap efisien dan mudah dipahami pengguna?**

- **Single Scaffold per layout:** `Scaffold` hanya dimiliki oleh `MobileLayout` (mobile) dan `DesktopLayout` (desktop). Dengan begitu bar navigasi (`BottomNavigationBar` atau `NavigationRail`) tidak diduplikasi di tiap halaman dan lifecycle widget lebih mudah dikendalikan.
- **Tab swap untuk navigasi utama:** Untuk navigasi level atas saya menggunakan mekanisme penggantian `body` berdasar indeks (`_currentIndex` atau `_selectedIndex`). Ini membuat perpindahan antar-tab cepat dan instan tanpa membangun ulang seluruh rute.
- **Push untuk detail:** Saya mengimplementasikan fitur passing data antar pages di mekanisme ini. Di page home, jika user menekan salah satu kota, tampilan berubah menjadi perbandingan kota yang dipilih dengan kota lainnya di dunia.
- **Konsistensi Navbar:** Pada mobile memakai `BottomNavigationBar` dan di desktop memakai `NavigationRail` — keduanya memiliki ikon + label sehingga affordance jelas. Cara bekerja navbar antar-platform tetap konsisten sehingga tidak membingungkan pengguna.

**2) Bagaimana kamu mengelola data saat berpindah antar halaman agar tetap akurat dan tidak menyebabkan redundant code? Jelaskan pendekatan atau solusi yang kamu gunakan.**

- **Model tunggal (CityWeather):** Saya menggunakan objek `CityWeather` (mis. `city`, `temp`, `time`, `icon`, `weather`) sebagai kelas data ketika berpindah halaman. Ini menjaga konsistensi dan memudahkan skalabilitas untuk pengembangan di masa depan.
- **Passing-by-value / lifting state sederhana:** Untuk kebutuhan saat ini saya menghindari state global. Komponen Home membuat instance `CityWeather` dan langsung `push` ke halaman detail. Ini mencegah duplikasi state dan potensi race condition.
- **Reuse komponen UI:** Widget seperti `WeatherBox`, `Header`, dan `Upcoming` digunakan ulang di mobile dan desktop sehingga logika rendering tidak terduplikasi.

**3) Setelah menyelesaikan tugas ini, apa insight atau pelajaran paling penting tentang pentingnya struktur navigasi dan modularisasi dalam pengembangan aplikasi Flutter?**

- **Separation of concerns (SoC):** Layaknya di web development, di sini saya juga memisahkan screens, widgets, dan models membuat kode lebih mudah dibaca, diuji, dan dipelihara.
- **Pilih pola navigasi sesuai kebutuhan:** Tab-swap (index-based) cocok untuk navigasi top-level yang sering diubah; `push` cocok untuk detail. Memilih pola yang tepat membuat UX terasa natural.
- **Reusability mengurangi biaya perubahan:** Membuat `WeatherBox` dan komponen lain sebagai reusable komponen memudahkan perubahan styling atau fitur di satu tempat.
- **Siapkan state management untuk skala:** Pass-by-value memadai untuk skenario sederhana, tetapi jika aplikasi butuh shared live data atau sinkronisasi antar banyak widget, gunakan solusi state management terpusat.

