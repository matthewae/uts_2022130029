import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 5)); // Delay 5 detik
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Bisa diubah sesuai kebutuhan
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Pastikan file image ada di pubspec.yaml dan path benar
            Image.asset(
              'assets/images/splash_image.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            // Pakai GFLoader (kompatibel dengan getwidget v7.x)
            const SizedBox(
              height: 60,
              width: 60,
              child: GFLoader(
                type: GFLoaderType.circle,
                loaderColorOne: Colors.blue,
                loaderColorTwo: Colors.lightBlueAccent,
                loaderColorThree: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Loading...',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
