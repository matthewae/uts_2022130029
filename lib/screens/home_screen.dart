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

  final Map<String, Map<String, String>> productDetails = {
    "Kampas Rem": {
      "description": "Kampas rem berkualitas tinggi untuk pengereman optimal.",
      "price": "Rp 150.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Filter Oli": {
      "description": "Filter oli untuk menjaga kebersihan oli mesin.",
      "price": "Rp 50.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Busi": {
      "description": "Busi iridium untuk performa mesin yang lebih baik.",
      "price": "Rp 75.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Aki Mobil": {
      "description": "Aki mobil bebas perawatan dengan daya tahan tinggi.",
      "price": "Rp 800.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Radiator": {
      "description": "Radiator aluminium untuk pendinginan mesin yang efisien.",
      "price": "Rp 1.200.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Shockbreaker": {
      "description": "Shockbreaker nyaman untuk stabilitas berkendara.",
      "price": "Rp 600.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Velg Racing": {
      "description": "Velg racing ringan untuk tampilan sporty.",
      "price": "Rp 3.500.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Ban Mobil": {
      "description": "Ban mobil performa tinggi untuk cengkeraman maksimal.",
      "price": "Rp 900.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Lampu Depan": {
      "description": "Lampu depan LED terang untuk visibilitas malam hari.",
      "price": "Rp 400.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Lampu Belakang": {
      "description": "Lampu belakang LED modern untuk keamanan.",
      "price": "Rp 350.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Filter Udara": {
      "description": "Filter udara untuk menjaga kebersihan udara masuk mesin.",
      "price": "Rp 60.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Kaca Spion": {
      "description": "Kaca spion elektrik dengan pemanas.",
      "price": "Rp 250.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Wiper Blade": {
      "description": "Wiper blade silikon untuk sapuan bersih.",
      "price": "Rp 80.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Klakson": {
      "description": "Klakson mobil suara nyaring.",
      "price": "Rp 100.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Oli Mesin": {
      "description": "Oli mesin sintetis untuk perlindungan maksimal.",
      "price": "Rp 120.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Timing Belt": {
      "description": "Timing belt berkualitas tinggi untuk mesin.",
      "price": "Rp 300.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Karet Pintu": {
      "description": "Karet pintu untuk kedap suara dan air.",
      "price": "Rp 70.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Bumper Depan": {
      "description": "Bumper depan sporty untuk tampilan agresif.",
      "price": "Rp 1.500.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Bumper Belakang": {
      "description": "Bumper belakang kokoh untuk perlindungan.",
      "price": "Rp 1.400.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Handle Pintu": {
      "description": "Handle pintu krom untuk sentuhan mewah.",
      "price": "Rp 90.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Sensor Oksigen": {
      "description": "Sensor oksigen untuk efisiensi bahan bakar.",
      "price": "Rp 200.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Knalpot": {
      "description": "Knalpot racing untuk suara sporty.",
      "price": "Rp 700.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Kopling Set": {
      "description": "Kopling set lengkap untuk transmisi halus.",
      "price": "Rp 1.100.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Bearing Roda": {
      "description": "Bearing roda presisi untuk putaran halus.",
      "price": "Rp 180.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Gearbox": {
      "description": "Gearbox transmisi otomatis berkualitas.",
      "price": "Rp 5.000.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Power Steering Pump": {
      "description": "Pompa power steering untuk kemudi ringan.",
      "price": "Rp 450.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Alternator": {
      "description": "Alternator untuk pengisian aki optimal.",
      "price": "Rp 600.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Kompressor AC": {
      "description": "Kompresor AC dingin untuk kenyamanan.",
      "price": "Rp 1.800.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Fan Belt": {
      "description": "Fan belt kuat untuk putaran mesin.",
      "price": "Rp 90.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Tangki Bensin": {
      "description": "Tangki bensin anti karat.",
      "price": "Rp 700.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Cermin Dalam": {
      "description": "Cermin dalam anti silau.",
      "price": "Rp 120.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Steering Wheel": {
      "description": "Setir kulit sporty.",
      "price": "Rp 500.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Pedal Gas": {
      "description": "Pedal gas responsif.",
      "price": "Rp 80.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Pedal Kopling": {
      "description": "Pedal kopling empuk.",
      "price": "Rp 70.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Fuse Box": {
      "description": "Kotak sekering lengkap.",
      "price": "Rp 150.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "ECU Mobil": {
      "description": "ECU mobil performa tinggi.",
      "price": "Rp 2.500.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Sensor ABS": {
      "description": "Sensor ABS untuk pengereman aman.",
      "price": "Rp 300.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Cover Jok": {
      "description": "Cover jok kulit mewah.",
      "price": "Rp 700.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Karet Wiper": {
      "description": "Karet wiper tahan lama.",
      "price": "Rp 40.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Spoiler Belakang": {
      "description": "Spoiler belakang aerodinamis.",
      "price": "Rp 400.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Shock Mount": {
      "description": "Shock mount kuat.",
      "price": "Rp 100.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Drive Shaft": {
      "description": "Drive shaft presisi.",
      "price": "Rp 900.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Lampu Kabin": {
      "description": "Lampu kabin LED terang.",
      "price": "Rp 60.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Airbag": {
      "description": "Airbag keselamatan.",
      "price": "Rp 1.500.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Handle Rem Tangan": {
      "description": "Handle rem tangan ergonomis.",
      "price": "Rp 110.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Filter Kabin": {
      "description": "Filter kabin anti bakteri.",
      "price": "Rp 55.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Saringan Bensin": {
      "description": "Saringan bensin bersih.",
      "price": "Rp 45.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Reservoir Air Radiator": {
      "description": "Reservoir air radiator tahan panas.",
      "price": "Rp 70.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Unit Injektor": {
      "description": "Unit injektor efisien.",
      "price": "Rp 300.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
    "Tutup Oli": {
      "description": "Tutup oli mesin rapat.",
      "price": "Rp 30.000",
      "imageUrl": "https://via.placeholder.com/150"
    },
  };

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
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/product',
                              arguments: {
                                'productName': item,
                                'productDetails': productDetails,
                              },
                            );
                          },
                          child: Container(
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
                                const SizedBox(height: 4),
                                Text(
                                  productDetails[item]?['price'] ?? 'Harga tidak tersedia',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
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
