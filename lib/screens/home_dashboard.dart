import 'package:flutter/material.dart';
import 'control_dashboard.dart';
import 'sensor_dashboard.dart';
import '../services/sensor_service.dart';
import '../models/sensor_data.dart';
import '../utils/page_transition.dart';

class HomePage extends StatelessWidget {
  final SensorService _sensorService = SensorService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section - Logo dan Teks Samping
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.home, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Hello User',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            Icons.waving_hand,
                            color: Colors.amber,
                            size: 18,
                          ),
                        ],
                      ),
                      Text(
                        'Welcome to Smart Room Monitoring System',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Monitoring and Controlling Cards Section
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Card 1 - Monitoring
                      StreamBuilder<List<SensorData>>(
                        stream: Stream.periodic(const Duration(seconds: 5))
                            .asyncMap((_) => _sensorService.fetchSensorData()),
                        builder: (context, snapshot) {
                          final isLampOn =
                              snapshot.hasData && snapshot.data!.isNotEmpty
                                  ? snapshot.data!.first.lamp ?? false
                                  : false;

                          return ControlCard(
                            title: 'Monitoring',
                            subtitle:
                                isLampOn ? 'System Active' : 'System Inactive',
                            icon: isLampOn
                                ? Icons.brightness_5 // Ganti ikon lampu
                                : Icons.brightness_4, // Ganti ikon lampu mati
                            color: Colors.amber.shade100,
                            onTap: () {
                              Navigator.push(
                                context,
                                SlidePageRoute(page: SensorDashboard()),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      // Card 2 - Controlling
                      StreamBuilder<List<SensorData>>(
                        stream: Stream.periodic(const Duration(seconds: 5))
                            .asyncMap((_) => _sensorService.fetchSensorData()),
                        builder: (context, snapshot) {
                          final isDoorLocked =
                              snapshot.hasData && snapshot.data!.isNotEmpty
                                  ? snapshot.data!.first.doorLocked ?? false
                                  : false;

                          return ControlCard(
                            title: 'Controlling',
                            subtitle:
                                isDoorLocked ? 'Door Locked' : 'Door Unlocked',
                            icon: isDoorLocked
                                ? Icons.security // Ganti ikon gembok
                                : Icons
                                    .security_outlined, // Ganti ikon gembok terbuka
                            color: Colors.red.shade100,
                            onTap: () {
                              Navigator.push(
                                context,
                                SlidePageRoute(page: ControlDashboard()),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ControlCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool switchControl;
  final VoidCallback? onTap;

  const ControlCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.switchControl = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            if (switchControl)
              Switch(
                value: true,
                onChanged: (value) {},
              ),
          ],
        ),
      ),
    );
  }
}
