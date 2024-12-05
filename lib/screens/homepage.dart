import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'monitoring.dart';
import 'controlling.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
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
                ],
              ),
            ),
            // Main Content Section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _selectedIndex == 0
                        ? const MonitoringPage()
                        : const ControllingPage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
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
