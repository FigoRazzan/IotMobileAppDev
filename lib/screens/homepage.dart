import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Home System'),
        backgroundColor: const Color(0xffB81736),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Monitoring
            const Text(
              'Monitoring',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff281537),
              ),
            ),
            const SizedBox(height: 10),
            // Monitoring: Suhu dan Kelembaban
            ListTile(
              leading: const Icon(Icons.thermostat, color: Colors.red),
              title: const Text('Pemantauan Suhu dan Kelembaban (DHT)'),
              subtitle: const Text('Monitoring via Web, Mobile, LCD I2C'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Arahkan ke halaman monitoring DHT
              },
            ),
            const Divider(),
            // Monitoring: Pendeteksi Air
            ListTile(
              leading: const Icon(Icons.water_drop, color: Colors.blue),
              title: const Text('Pendeteksi Air (Water Sensor)'),
              subtitle: const Text('Monitoring via Web, Mobile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Arahkan ke halaman monitoring Water Sensor
              },
            ),
            const Divider(),
            // Monitoring: Jarak Deteksi Gerakan
            ListTile(
              leading: const Icon(Icons.sensors, color: Colors.green),
              title: const Text('Jarak Deteksi Gerakan (Ultrasonic/PIR)'),
              subtitle: const Text('Monitoring via Web, Mobile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Arahkan ke halaman monitoring Ultrasonic/PIR
              },
            ),
            const Divider(),
            // Monitoring: Deteksi Kebakaran
            ListTile(
              leading:
                  const Icon(Icons.local_fire_department, color: Colors.orange),
              title: const Text('Deteksi Kebakaran (Flame Sensor)'),
              subtitle: const Text('Monitoring via Web, Mobile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Arahkan ke halaman monitoring Flame Sensor
              },
            ),
            const Divider(),
            const SizedBox(height: 20),

            // Section Controlling
            const Text(
              'Controlling',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xff281537),
              ),
            ),
            const SizedBox(height: 10),
            // Controlling: Buka Tutup Pintu (Servo)
            ListTile(
              leading: const Icon(Icons.door_front_door, color: Colors.brown),
              title: const Text('Buka Tutup Pintu (Servo)'),
              subtitle: const Text('Control via Web, Mobile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Arahkan ke halaman controlling Servo
              },
            ),
            const Divider(),
            // Controlling: Kunci Pintu (Solenoid Door Lock)
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.grey),
              title: const Text('Kunci Pintu (Solenoid Door Lock)'),
              subtitle: const Text('Control via Web, Mobile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Arahkan ke halaman controlling Door Lock
              },
            ),
            const Divider(),
            // Controlling: Nyalain/Matiin Lampu (LED)
            ListTile(
              leading: const Icon(Icons.lightbulb, color: Colors.yellow),
              title: const Text('Nyalain/Matiin Lampu (LED)'),
              subtitle: const Text('Control via Web, Mobile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Arahkan ke halaman controlling Lampu LED
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
