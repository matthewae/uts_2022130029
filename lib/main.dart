import 'package:flutter/material.dart';
import 'package:uts_2022130029/screens/cart_screen.dart';
import 'package:uts_2022130029/screens/home_screen.dart';
import 'package:uts_2022130029/screens/login_screen.dart';
import 'package:uts_2022130029/screens/product_screen.dart';
import 'package:uts_2022130029/screens/profile_screen.dart';
import 'package:uts_2022130029/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:uts_2022130029/utils/cart_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartManager(),
      child: MaterialApp(
        title: 'BShop App',
        debugShowCheckedModeBanner: false, // ✅ Hilangkan banner debug
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        // ✅ SplashScreen hanya dijalankan pertama kali (home)
        home: const SplashScreen(),

        // ✅ Rute aplikasi lengkap
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/cart': (context) => const CartScreen(),
          '/product': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map;
            final String productName = args['productName'];
            final Map<String, Map<String, String>> productDetails = args['productDetails'];
            return ProductScreen(productName: productName, productDetails: productDetails);
          },
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
