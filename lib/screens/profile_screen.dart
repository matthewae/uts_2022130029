import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uts_2022130029/utils/user_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: GFDrawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GFDrawerHeader(
              currentAccountPicture: const GFAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blue, size: 40),
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    UserData.loggedInUserName ?? 'Guest',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            GFListTile(
              avatar: const Icon(Icons.home),
              title: const Text('Home'),
              icon: const Icon(Icons.arrow_forward_ios, size: 16.0),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            GFListTile(
              avatar: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              icon: const Icon(Icons.arrow_forward_ios, size: 16.0),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/cart');
              },
            ),
            GFListTile(
              avatar: const Icon(Icons.person),
              title: const Text('Profile'),
              icon: const Icon(Icons.arrow_forward_ios, size: 16.0),
              onTap: () {
                Navigator.pop(context);
                // Already on profile page
              },
            ),
            GFListTile(
              avatar: const Icon(Icons.logout),
              title: const Text('Logout'),
              icon: const Icon(Icons.arrow_forward_ios, size: 16.0),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),

      // === BODY ===
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.person, size: 60),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GFIconButton(
                    color: GFColors.PRIMARY,
                    shape: GFIconButtonShape.circle,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Pemberitahuan'),
                            content: const Text(
                                'Fitur ini sedang dalam pengembangan.'),
                            actions: <Widget>[
                              GFButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                text: 'OK',
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              UserData.loggedInUserName ?? 'Guest',
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'john.doe@example.com',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            GFCard(
              content: Column(
                children: [
                  TextFormField(
                    readOnly: true,
                    initialValue: 'Male',
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    initialValue: '123 Main St, Anytown USA',
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    readOnly: true,
                    initialValue: '+1234567890',
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone_outlined),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GFButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Pemberitahuan'),
                      content: const Text(
                          'Fitur ini sedang dalam pengembangan.'),
                      actions: <Widget>[
                        GFButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: 'OK',
                        ),
                      ],
                    );
                  },
                );
              },
              text: 'Edit Profile',
              color: GFColors.PRIMARY,
              size: GFSize.LARGE,
            ),
          ],
        ),
      ),
    );
  }
}
