import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uts_2022130029/utils/user_data.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // ✅ Inisialisasi animasi fade
    _fadeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();

    // ✅ Jalankan navigasi
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 4)); // Durasi splash
    if (!mounted) return;

    // ✅ Cek apakah user sudah login
    if (UserData.loggedInUserName != null &&
        UserData.loggedInUserName!.isNotEmpty) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // ✅ Pastikan sudah daftarkan asset ini di pubspec.yaml
                Image.asset(
                  'assets/images/splash_image.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 30),
                const SizedBox(
                  height: 60,
                  width: 60,
                  child: GFLoader(
                    type: GFLoaderType.circle,
                    loaderColorOne: Colors.white,
                    loaderColorTwo: Colors.lightBlueAccent,
                    loaderColorThree: Colors.white70,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Loading...',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
