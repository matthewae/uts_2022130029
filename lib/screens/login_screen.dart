import 'package:flutter/material.dart';
import 'package:uts_2022130029/utils/user_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final _formKey = GlobalKey<FormState>();

  // controller email dan password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false; //  mata password

  // fungsi login 
  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true; // tampil loading
      });

      
      await Future.delayed(const Duration(seconds: 2));

      if (_emailController.text == "test@email.com" &&
          _passwordController.text == "testing") {
        UserData.loggedInUserName = _emailController.text.split('@')[0];
        // navigasi ke home
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // alert password salah
        _showErrorAlert("Email atau password salah. (masih hardcode)");
      }

      setState(() {
        _isLoading = false; //  loading
      });
    } else {
      debugPrint("Form belum diisi semua!");
    }
  }

  // tampilkan alert kalau login gagal
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
    // container gradient 
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4268F6), 
            Color(0xFF8B9EFF),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // gradient
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Bagian logo di atas (masih coba-coba)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white, // ini nanti bisa diganti jadi transparan
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/Logo1-removebg-preview.png', 
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // masih error kalau gambar gaada
                              return Center(
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 60,
                                  color: Colors.grey[400],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48.0),

                  const Text(
                    "Welcome to BShop", 
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 24.0),

                  // === Textfield Email ===
                  TextFormField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Email", // email
                      hintText: "ciah@example.com", 
                      labelStyle: const TextStyle(color: Colors.white70),
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none, 
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong'; // email tidak boleh kosong
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Masukkan email yang valid';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16.0),

                  // === Textfield Password ===
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible, // toggle
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Password", // password
                      hintText: "your password",
                      labelStyle: const TextStyle(color: Colors.white70),
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 6) {
                        return 'Password minimal 6 karakter';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24.0),

                  // === Tombol Login ===
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.white, 
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              "Login", // tombolnya
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF4268F6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 10),

                  // komentar tambahan aja
                  const Text(
                    "",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
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
