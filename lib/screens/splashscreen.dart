import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Tetapkan durasi awal, akan diperbarui nanti oleh onLoaded
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Durasi sementara
    )..repeat(); // Animasi akan looping
  }

  @override
  void dispose() {
    _controller.dispose(); // Membersihkan controller saat widget dihancurkan
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset(
        'assets/lottie/Animation - splashscreen.json',
        controller: _controller,
        onLoaded: (composition) {
          // Atur durasi animasi menjadi 1.5x lebih cepat
          _controller.duration = composition.duration * 2 ~/ 3;
          _controller.repeat(); // Pastikan animasi tetap looping
        },
      ),
      backgroundColor:
          const Color.fromARGB(255, 0, 0, 0), // Warna latar belakang
      nextScreen: const HomePage(), // Halaman setelah splash screen
      splashIconSize: 450, // Ukuran animasi splash
      duration: 10000, // Durasi splash screen dalam milidetik
      splashTransition:
          SplashTransition.fadeTransition, // Transisi ke halaman berikutnya
    );
  }
}
