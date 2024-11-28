import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Widget untuk info cards di bagian atas
  Widget _buildInfoCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildInfoCard(
            icon: Icons.thermostat_outlined,
            value: '27°C',
            label: 'Temperature',
            color: Colors.cyan,
          ),
          const SizedBox(width: 12),
          _buildInfoCard(
            icon: Icons.water_drop_outlined,
            value: '65%',
            label: 'Humidity',
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk room devices
  Widget _buildRoomDevices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Devices',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _selectedIndex == 0
              ? _buildMonitoringDevices()
              : _buildControllingDevices(),
        ),
      ],
    );
  }

  Widget _buildMonitoringDevices() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildDeviceCard(
          icon: Icons.thermostat,
          title: 'Temperature & Humidity',
          subtitle: '27°C | 65%',
          color: Colors.blue,
          isActive: true,
        ),
        _buildDeviceCard(
          icon: Icons.water_drop,
          title: 'Water Level',
          subtitle: 'Normal',
          color: Colors.cyan,
          isActive: true,
        ),
        _buildDeviceCard(
          icon: Icons.motion_photos_on,
          title: 'Motion',
          subtitle: 'No Movement',
          color: Colors.purple,
          isActive: true,
        ),
        _buildDeviceCard(
          icon: Icons.local_fire_department,
          title: 'Fire Detection',
          subtitle: 'Safe',
          color: Colors.orange,
          isActive: true,
        ),
      ],
    );
  }

  Widget _buildControllingDevices() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildDeviceCard(
          icon: Icons.door_sliding,
          title: 'Door',
          subtitle: 'Closed',
          color: Colors.purple,
          isActive: false,
        ),
        _buildDeviceCard(
          icon: Icons.lock,
          title: 'Door Lock',
          subtitle: 'Locked',
          color: Colors.blue,
          isActive: true,
        ),
        _buildDeviceCard(
          icon: Icons.lightbulb,
          title: 'Light',
          subtitle: 'OFF',
          color: Colors.amber,
          isActive: false,
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
  }) {
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildInfoCards(),
                    const SizedBox(height: 24),
                    _buildRoomDevices(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.monitor_heart, color: Colors.white),
          Icon(Icons.control_camera, color: Colors.white),
        ],
        inactiveIcons: const [
          Icon(Icons.monitor_heart_outlined, color: Colors.white),
          Icon(Icons.control_camera_outlined, color: Colors.white),
        ],
        color: const Color.fromARGB(255, 73, 73, 73),
        height: 60,
        circleWidth: 60,
        activeIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        shadowColor: Colors.deepPurple.withOpacity(0.3),
        elevation: 10,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey[900]!,
            Colors.grey[850]!,
          ],
        ),
        circleShadowColor: Colors.blue.withOpacity(0.3),
        circleGradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.deepPurple,
          ],
        ),
      ),
    );
  }
}
