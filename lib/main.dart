import 'package:flutter/material.dart';
import 'package:uts_2022130029/screens/cart_screen.dart';
import 'package:uts_2022130029/screens/home_screen.dart';
import 'package:uts_2022130029/screens/login_screen.dart';
import 'package:uts_2022130029/screens/product_screen.dart';
import 'package:uts_2022130029/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BShop App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/products': (context) => const ProductScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}
