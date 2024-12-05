import 'package:flutter/material.dart';
import 'sensor_values.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({Key? key}) : super(key: key);

  @override
  _MonitoringPageState createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  Color getTemperatureColor(int state) {
    if (state == 2) return Colors.red; // High
    if (state == 1) return Colors.orange; // Normal
    return Colors.blue; // Low
  }

  String getTemperatureLabel(int state) {
    if (state == 2) return "High";
    if (state == 1) return "Normal";
    return "Low";
  }

  Color getHumidityColor(int state) {
    if (state == 2) return Colors.red; // High
    if (state == 1) return Colors.orange; // Normal
    return Colors.blue; // Low
  }

  String getHumidityLabel(int state) {
    if (state == 2) return "High";
    if (state == 1) return "Normal";
    return "Low";
  }

  Widget _buildTemperatureHumidityCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Temperature box
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  SensorValues.temperatureState =
                      (SensorValues.temperatureState + 1) % 3;
                  if (SensorValues.temperatureState == 0) {
                    SensorValues.temperature = 15.0; // Low
                  } else if (SensorValues.temperatureState == 1) {
                    SensorValues.temperature = 25.0; // Normal
                  } else {
                    SensorValues.temperature = 35.0; // High
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: getTemperatureColor(SensorValues.temperatureState)
                          .withOpacity(0.3),
                      width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.thermostat_outlined,
                        color:
                            getTemperatureColor(SensorValues.temperatureState),
                        size: 24),
                    const SizedBox(height: 8),
                    Text(
                      '${SensorValues.temperature}°C',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Temperature (${getTemperatureLabel(SensorValues.temperatureState)})',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Humidity box
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  SensorValues.humidityState =
                      (SensorValues.humidityState + 1) % 3;
                  if (SensorValues.humidityState == 0) {
                    SensorValues.humidity = 30.0; // Low
                  } else if (SensorValues.humidityState == 1) {
                    SensorValues.humidity = 50.0; // Normal
                  } else {
                    SensorValues.humidity = 70.0; // High
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: getHumidityColor(SensorValues.humidityState)
                          .withOpacity(0.3),
                      width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.water_drop_outlined,
                        color: getHumidityColor(SensorValues.humidityState),
                        size: 24),
                    const SizedBox(height: 8),
                    Text(
                      '${SensorValues.humidity}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Humidity (${getHumidityLabel(SensorValues.humidityState)})',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonitoringDevices() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            'Devices',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              // Temperature & Humidity summary box
              _buildDeviceCard(
                icon: Icons.thermostat,
                title: 'Temperature & Humidity',
                subtitle:
                    '${SensorValues.temperature}°C | ${SensorValues.humidity}%',
                color: Colors.orange,
                isActive: true,
                isTemperatureHumidity: true,
                onTap: () {},
              ),
              // Water Level device
              _buildDeviceCard(
                icon: Icons.water_drop,
                title: 'Water Level',
                subtitle: SensorValues.isWaterDetected
                    ? 'Water Detected'
                    : 'No Water',
                color: SensorValues.isWaterDetected ? Colors.red : Colors.green,
                isActive: true,
                onTap: () {
                  setState(() {
                    SensorValues.isWaterDetected =
                        !SensorValues.isWaterDetected;
                  });
                },
              ),
              // Motion device
              _buildDeviceCard(
                icon: Icons.motion_photos_on,
                title: 'Motion',
                subtitle: SensorValues.isMotionDetected
                    ? 'Movement Detected'
                    : 'No Movement',
                color: SensorValues.isMotionDetected
                    ? Colors.green
                    : Colors.purple,
                isActive: true,
                onTap: () {
                  setState(() {
                    SensorValues.isMotionDetected =
                        !SensorValues.isMotionDetected;
                  });
                },
              ),
              // Flame sensor device
              _buildDeviceCard(
                icon: Icons.local_fire_department,
                title: 'Flame Sensor',
                subtitle:
                    SensorValues.isFireDetected ? 'Fire Detected' : 'No Fire',
                color: SensorValues.isFireDetected
                    ? Colors.orange
                    : Colors.blueGrey,
                isActive: true,
                onTap: () {
                  setState(() {
                    SensorValues.isFireDetected = !SensorValues.isFireDetected;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool isActive,
    required VoidCallback onTap,
    bool isTemperatureHumidity = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: isTemperatureHumidity
            ? GradientBorderPainter(
                temperatureColor:
                    getTemperatureColor(SensorValues.temperatureState),
                humidityColor: getHumidityColor(SensorValues.humidityState),
              )
            : null,
        child: Container(
          width: MediaQuery.of(context).size.width / 2 - 28,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(20),
            border: !isTemperatureHumidity
                ? Border.all(
                    color:
                        isActive ? color.withOpacity(0.3) : Colors.transparent,
                    width: 1,
                  )
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isTemperatureHumidity)
                // Two icons for temperature and humidity
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color:
                            getTemperatureColor(SensorValues.temperatureState)
                                .withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.thermostat,
                        color:
                            getTemperatureColor(SensorValues.temperatureState),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: getHumidityColor(SensorValues.humidityState)
                            .withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.water_drop,
                        color: getHumidityColor(SensorValues.humidityState),
                      ),
                    ),
                  ],
                )
              else
                // Single icon for other cards
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color),
                ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _buildTemperatureHumidityCards(),
          const SizedBox(height: 24),
          _buildMonitoringDevices(),
        ],
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final Color temperatureColor;
  final Color humidityColor;

  GradientBorderPainter({
    required this.temperatureColor,
    required this.humidityColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(20));

    // Create path for border
    final path = Path()
      ..addRRect(rRect)
      ..addRRect(rRect.deflate(1));

    // Create gradient paint with increased opacity
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          temperatureColor.withOpacity(0.8),
          humidityColor.withOpacity(0.8),
        ],
        stops: const [0.5, 0.5],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Increased border width

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
