import 'package:flutter/material.dart';
import 'package:uts_2022130029/utils/user_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      if (_emailController.text == "test@email.com" &&
          _passwordController.text == "testing") {
        UserData.loggedInUserName = _emailController.text.split('@')[0];
        // Navigate to home screen
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Show error alert
        _showErrorAlert("Email atau password salah.");
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Login Gagal"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4268F6), // Light blue
            Color(0xFF8B9EFF), // Darker blue
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Make Scaffold background transparent
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0), // Rounded corners for the image
                      child: Image.network(
                        'https://via.placeholder.com/300x200.png?text=Login+Image', // Placeholder image from internet
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48.0),
                  const Text(
                    "Welcome to BShop",
                    style: TextStyle(
                      fontSize: 32.0, // Larger font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text for contrast
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white), // White text for input
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "ciah@example.com",
                      labelStyle: const TextStyle(color: Colors.white70), // Lighter label
                      hintStyle: const TextStyle(color: Colors.white54), // Lighter hint
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3), // Semi-transparent fill
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // Rounded corners
                        borderSide: BorderSide.none, // No border line
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.white, width: 2.0), // White border when focused
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Masukkan email yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white), // White text for input
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "your password",
                      labelStyle: const TextStyle(color: Colors.white70), // Lighter label
                      hintStyle: const TextStyle(color: Colors.white54), // Lighter hint
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3), // Semi-transparent fill
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // Rounded corners
                        borderSide: BorderSide.none, // No border line
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.white, width: 2.0), // White border when focused
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 6) {
                        return 'Password harus minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white) // White loading indicator
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // White button background
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0), // More rounded corners
                              ),
                              elevation: 5, // Add some shadow
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18.0, color: Color(0xFF4268F6), fontWeight: FontWeight.bold), // Blue text for contrast
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}