import 'package:flutter/material.dart';
import 'sensor_values.dart';

class ControllingPage extends StatefulWidget {
  const ControllingPage({Key? key}) : super(key: key);

  @override
  _ControllingPageState createState() => _ControllingPageState();
}

class _ControllingPageState extends State<ControllingPage> {
  Widget _buildControllingDevices() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildDeviceCard(
          icon: Icons.door_sliding,
          title: 'Door',
          subtitle: SensorValues.isDoorOpen ? 'Open' : 'Closed',
          color: SensorValues.isDoorOpen ? Colors.green : Colors.red,
          isActive: true,
          onTap: () {
            setState(() {
              SensorValues.isDoorOpen = !SensorValues.isDoorOpen;
            });
          },
        ),
        _buildDeviceCard(
          icon: Icons.lightbulb,
          title: 'Light',
          subtitle: SensorValues.isLightOn ? 'ON' : 'OFF',
          color: SensorValues.isLightOn ? Colors.yellow : Colors.grey,
          isActive: SensorValues.isLightOn,
          onTap: () {
            setState(() {
              SensorValues.isLightOn = !SensorValues.isLightOn;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDeviceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 28,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? color.withOpacity(0.3) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildControllingDevices(),
        ),
      ],
    );
  }
}
