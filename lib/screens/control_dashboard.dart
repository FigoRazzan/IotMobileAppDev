import 'package:flutter/material.dart';
import '../services/sensor_service.dart';

class ControlDashboard extends StatefulWidget {
  const ControlDashboard({Key? key}) : super(key: key);

  @override
  State<ControlDashboard> createState() => _ControlDashboardState();
}

class _ControlDashboardState extends State<ControlDashboard> {
  final SensorService _sensorService = SensorService();

  // State variables untuk kontrol
  bool _doorLocked = false; // Status solenoid door lock
  bool _lampOn = false; // Status LED
  bool _doorOpen = false; // Status servo door

  // Sensor ID yang akan digunakan untuk update ke API
  String? sensorId;

  // Flag untuk menandai apakah sedang loading data
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _sensorService.connect(); // Connect to MQTT broker
    _fetchInitialStatus();
  }

  @override
  void dispose() {
    _sensorService.dispose(); // Clean up MQTT connection
    super.dispose();
  }

  /// Mengambil status awal dari sensor terbaru
  Future<void> _fetchInitialStatus() async {
    try {
      final sensors = await _sensorService.fetchSensorData();
      if (sensors.isNotEmpty) {
        setState(() {
          sensorId = sensors.first.id.toString(); // Convert int to String
          _doorLocked = sensors.first.doorLocked ?? false;
          _lampOn = sensors.first.lamp ?? false;
          _doorOpen = sensors.first.door ?? false;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        _showError('No sensor data available.');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Failed to fetch initial data: $e');
    }
  }

  /// Mengubah status Door Lock
  Future<void> _toggleDoorLock() async {
    if (sensorId == null) {
      _showError('Sensor ID not available. Please refresh.');
      return;
    }

    try {
      await _sensorService.toggleDoorLock(sensorId!, _doorLocked);
      setState(() {
        _doorLocked = !_doorLocked;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Door ${_doorLocked ? 'Locked' : 'Unlocked'}')),
      );
    } catch (e) {
      _showError('Failed to toggle door lock: $e');
    }
  }

  /// Mengubah status Lamp
  Future<void> _toggleLamp() async {
    if (sensorId == null) {
      _showError('Sensor ID not available. Please refresh.');
      return;
    }

    try {
      await _sensorService.toggleLamp(sensorId!, _lampOn);
      setState(() {
        _lampOn = !_lampOn;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lamp turned ${_lampOn ? 'On' : 'Off'}')),
      );
    } catch (e) {
      _showError('Failed to toggle lamp: $e');
    }
  }

  /// Mengubah status Door
  Future<void> _toggleDoor() async {
    if (sensorId == null) {
      _showError('Sensor ID not available. Please refresh.');
      return;
    }

    try {
      await _sensorService.toggleDoor(sensorId!, _doorOpen);
      setState(() {
        _doorOpen = !_doorOpen;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Door ${_doorOpen ? 'Opened' : 'Closed'}')),
      );
    } catch (e) {
      _showError('Failed to toggle door: $e');
    }
  }

  /// Menampilkan pesan error dengan SnackBar
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: _fetchInitialStatus,
        ),
      ),
    );
  }

  /// Membuat kartu perangkat yang bisa diklik
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

  /// Menampilkan perangkat yang dapat dikendalikan
  Widget _buildControllingDevices() {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Menyebar antara kiri dan kanan
          children: [
            Expanded(
              child: _buildDeviceCard(
                icon: Icons.door_sliding,
                title: 'Door',
                subtitle: _doorOpen ? 'Open' : 'Closed',
                color: _doorOpen ? Colors.green : Colors.red,
                isActive: _doorOpen,
                onTap: () => _toggleDoor(),
              ),
            ),
            const SizedBox(width: 16), // Jarak antar card
            Expanded(
              child: _buildDeviceCard(
                icon: Icons.lightbulb,
                title: 'Light',
                subtitle: _lampOn ? 'ON' : 'OFF',
                color: _lampOn ? Colors.yellow : Colors.grey,
                isActive: _lampOn,
                onTap: () => _toggleLamp(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildDeviceCard(
                icon: Icons.lock,
                title: 'Door Lock',
                subtitle: _doorLocked ? 'Locked' : 'Unlocked',
                color: _doorLocked ? Colors.blue : Colors.orange,
                isActive: _doorLocked,
                onTap: () => _toggleDoorLock(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Control Dashboard'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
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
              ),
      ),
    );
  }
}
