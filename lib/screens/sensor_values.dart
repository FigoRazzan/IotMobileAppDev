import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SensorValues {
  // Nilai sensor
  static double temperature = 25.0; // Suhu default
  static double humidity = 50.0; // Kelembaban default

  // Status perangkat
  static bool isWaterDetected = false; // Status sensor air default
  static bool isMotionDetected = false; // Status sensor gerakan default
  static bool isDoorOpen = false; // Status pintu default
  static bool isLightOn = false; // Status lampu default
  static bool isDoorLocked = false; // Status kunci pintu default

  // Status suhu dan kelembaban
  static int temperatureState =
      1; // Status suhu (1 = normal, 2 = tinggi, 0 = rendah)
  static int humidityState =
      1; // Status kelembaban (1 = normal, 2 = tinggi, 0 = rendah)

  // Timer untuk auto-refresh
  static Timer? _autoRefreshTimer;

  // Fungsi untuk memulai auto-refresh setiap 1 detik
  static void startAutoRefresh() {
    _autoRefreshTimer?.cancel(); // Hentikan timer sebelumnya jika ada
    _autoRefreshTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        bool success = await fetchDataFromApi();
        if (!success) {
          print('Gagal memperbarui data dari API.');
        }
      },
    );
    print('Auto-refresh dimulai.');
  }

  // Fungsi untuk menghentikan auto-refresh
  static void stopAutoRefresh() {
    _autoRefreshTimer?.cancel();
    print('Auto-refresh dihentikan.');
  }

  // Fungsi untuk mengambil data dari API dan memperbarui nilai sensor
  static Future<bool> fetchDataFromApi() async {
    try {
      final response =
          await http.get(Uri.parse('https://api-x-six.vercel.app/api/sensors'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          final latestData = data[0]; // Ambil data terbaru

          // Update nilai sensor
          temperature = (latestData['temperature'] ?? 25.0).toDouble();
          humidity = (latestData['humidity'] ?? 50.0).toDouble();
          isWaterDetected = latestData['water_sensor'] ?? false;
          isMotionDetected = latestData['motion_sensor'] ?? false;
          isDoorOpen = latestData['door'] ?? false;
          isLightOn = latestData['lamp'] ?? false;
          isDoorLocked = latestData['door_locked'] ?? false;

          // Update status suhu dan kelembaban
          _updateTemperatureState();
          _updateHumidityState();

          print('Data berhasil diperbarui.');
          return true; // Data berhasil diambil dan diperbarui
        } else {
          throw Exception('Data kosong');
        }
      } else {
        throw Exception(
            'Gagal mengambil data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return false; // Gagal mengambil data
    }
  }

  // Fungsi untuk memperbarui status perangkat melalui API
  static Future<bool> updateDeviceState(String device, bool state) async {
    try {
      final response = await http.post(
        Uri.parse('https://api-x-six.vercel.app/api/update-device'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'device': device,
          'state': state,
        }),
      );

      if (response.statusCode == 200) {
        print('Status $device berhasil diperbarui ke $state');
        return true;
      } else {
        print('Gagal memperbarui $device. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error updating device state: $e');
      return false;
    }
  }

  // Update status suhu
  static void _updateTemperatureState() {
    if (temperature >= 30) {
      temperatureState = 2; // High
    } else if (temperature >= 20) {
      temperatureState = 1; // Normal
    } else {
      temperatureState = 0; // Low
    }
  }

  // Update status kelembaban
  static void _updateHumidityState() {
    if (humidity >= 70) {
      humidityState = 2; // High
    } else if (humidity >= 30) {
      humidityState = 1; // Normal
    } else {
      humidityState = 0; // Low
    }
  }

  // Print nilai sensor (untuk debugging)
  static void printValues() {
    print('Temperature: $temperature°C');
    print('Humidity: $humidity%');
    print('Water Detected: $isWaterDetected');
    print('Motion Detected: $isMotionDetected');
    print('Door Open: $isDoorOpen');
    print('Light On: $isLightOn');
    print('Door Locked: $isDoorLocked');
  }
}
