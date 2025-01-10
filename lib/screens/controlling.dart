import 'package:flutter/material.dart';
import 'sensor_values.dart';

class ControllingPage extends StatefulWidget {
  const ControllingPage({Key? key}) : super(key: key);

  @override
  _ControllingPageState createState() => _ControllingPageState();
}

class _ControllingPageState extends State<ControllingPage> {
  // Fungsi untuk mengubah status perangkat dan mengupdate di API
  Future<void> _toggleDevice(String device, bool currentState) async {
    final newState = !currentState;
    final success = await SensorValues.updateDeviceState(device, newState);

    if (success) {
      setState(() {
        switch (device) {
          case 'door':
            SensorValues.isDoorOpen = newState;
            break;
          case 'lamp':
            SensorValues.isLightOn = newState;
            break;
          case 'door_locked':
            SensorValues.isDoorLocked = newState;
            break;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update $device status')),
      );
    }
  }

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
          isActive: SensorValues.isDoorOpen,
          onTap: () => _toggleDevice('door', SensorValues.isDoorOpen),
        ),
        _buildDeviceCard(
          icon: Icons.lightbulb,
          title: 'Light',
          subtitle: SensorValues.isLightOn ? 'ON' : 'OFF',
          color: SensorValues.isLightOn ? Colors.yellow : Colors.grey,
          isActive: SensorValues.isLightOn,
          onTap: () => _toggleDevice('lamp', SensorValues.isLightOn),
        ),
        _buildDeviceCard(
          icon: Icons.lock,
          title: 'Door Lock',
          subtitle: SensorValues.isDoorLocked ? 'Locked' : 'Unlocked',
          color: SensorValues.isDoorLocked ? Colors.blue : Colors.orange,
          isActive: SensorValues.isDoorLocked,
          onTap: () => _toggleDevice('door_locked', SensorValues.isDoorLocked),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Text(
            'Devices',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _buildControllingDevices(),
        ),
      ],
    );
  }
}
