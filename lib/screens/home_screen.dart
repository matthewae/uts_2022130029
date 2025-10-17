import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:uts_2022130029/utils/user_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _searchQuery = "";
  bool _isSearching = false;

  // === 48 Nama Sparepart Mobil ===
  final List<String> spareParts = [
    "Kampas Rem", "Filter Oli", "Busi", "Aki Mobil", "Radiator",
    "Shockbreaker", "Velg Racing", "Ban Mobil", "Lampu Depan", "Lampu Belakang",
    "Filter Udara", "Kaca Spion", "Wiper Blade", "Klakson", "Oli Mesin",
    "Timing Belt", "Karet Pintu", "Bumper Depan", "Bumper Belakang", "Handle Pintu",
    "Sensor Oksigen", "Knalpot", "Kopling Set", "Bearing Roda", "Gearbox",
    "Power Steering Pump", "Alternator", "Kompressor AC", "Fan Belt", "Tangki Bensin",
    "Cermin Dalam", "Steering Wheel", "Pedal Gas", "Pedal Kopling", "Fuse Box", "ECU Mobil",
    "Sensor ABS", "Cover Jok", "Karet Wiper", "Spoiler Belakang", "Shock Mount",
    "Drive Shaft", "Lampu Kabin", "Airbag", "Handle Rem Tangan", "Filter Kabin",
    "Saringan Bensin", "Reservoir Air Radiator", "Unit Injektor", "Tutup Oli"
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // === Filter Berdasarkan Pencarian ===
  List<String> get filteredParts {
    if (_searchQuery.isEmpty) return spareParts;
    return spareParts
        .where((part) => part.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final int totalPages = (filteredParts.length / 12).ceil();

    return Scaffold(
      appBar: GFAppBar(
        title: !_isSearching
            ? const Text("Sparepart Mobil")
            : SizedBox(
                height: 40,
                child: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Cari sparepart...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                      _currentPage = 0;
                      _pageController.jumpToPage(0);
                    });
                  },
                ),
              ),
        actions: [
          GFIconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = "";
                }
              });
            },
            type: GFButtonType.transparent,
          ),
        ],
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
                  Text(UserData.loggedInUserName ?? 'Guest',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('john.doe@example.com',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white70)),
                ],
              ),
            ),
            GFListTile(
              avatar: const Icon(Icons.home),
              title: const Text('Home'),
              icon: const Icon(Icons.arrow_forward_ios, size: 16.0),
              onTap: () => Navigator.pop(context),
            ),
            GFListTile(
              avatar: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              icon: const Icon(Icons.arrow_forward_ios, size: 16.0),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart');
              },
            ),
            GFListTile(
              avatar: const Icon(Icons.person),
              title: const Text('Profile'),
              icon: const Icon(Icons.arrow_forward_ios, size: 16.0),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
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
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: totalPages,
                  itemBuilder: (context, pageIndex) {
                    final start = pageIndex * 12;
                    final end = (start + 12 < filteredParts.length)
                        ? start + 12
                        : filteredParts.length;
                    final items = filteredParts.sublist(start, end);

                    return GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.build_circle,
                                  size: 45, color: Colors.blueGrey),
                              const SizedBox(height: 8),
                              Text(
                                item,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Sparepart mobil berkualitas tinggi.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),

                // Tombol panah kiri
                if (_currentPage > 0)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GFIconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      type: GFButtonType.transparent,
                      color: Colors.black.withOpacity(0.5),
                      shape: GFIconButtonShape.circle,
                    ),
                  ),

                // Tombol panah kanan
                if (_currentPage < totalPages - 1)
                  Align(
                    alignment: Alignment.centerRight,
                    child: GFIconButton(
                      icon: const Icon(Icons.arrow_forward_ios,
                          color: Colors.white),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      type: GFButtonType.transparent,
                      color: Colors.black.withOpacity(0.5),
                      shape: GFIconButtonShape.circle,
                    ),
                  ),
              ],
            ),
          ),

          // Dots indikator halaman
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalPages, (index) {
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: Container(
                  width: 8,
                  height: 8,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentPage == index ? Colors.blueAccent : Colors.grey,
                  ),
                ),
              );
            }),
          ),
        ],
      ),

      floatingActionButton: GFButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Item ditambahkan ke keranjang!')),
          );
        },
        text: 'Tambah ke Keranjang',
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        color: Colors.blue,
        textColor: Colors.white,
        shape: GFButtonShape.pills,
        size: GFSize.MEDIUM,
      ),
    );
  }
}
