import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        title: const Text("Our products"),
        actions: [
          GFIconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search action
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
                child: Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'John Doe',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Text(
                    'john.doe@example.com',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
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
              },
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
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: 10, // total 10 halaman
                  itemBuilder: (context, pageIndex) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // dua kolom
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: 12, // 12 item per halaman
                      itemBuilder: (context, itemIndex) {
                        final globalIndex = (pageIndex * 12) + itemIndex;
                        return GFCard(
                          boxFit: BoxFit.cover,
                          image: Image.network(
                            'https://via.placeholder.com/150?text=Product+${globalIndex + 1}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          title: GFListTile(
                            title: Text(
                              'Product Title ${globalIndex + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.black87,
                              ),
                            ),
                            subTitle: Text(
                              'Description ${globalIndex + 1}',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          buttonBar: GFButtonBar(
                            children: <Widget>[
                              GFIconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Product ${globalIndex + 1} added to favorites!')),
                                  );
                                },
                                icon: const Icon(Icons.favorite_border),
                                type: GFButtonType.transparent,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                if (_currentPage > 0)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: GFIconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        type: GFButtonType.transparent,
                      ),
                    ),
                  ),
                if (_currentPage < 9)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: GFIconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        type: GFButtonType.transparent,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Pagination dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(10, (index) {
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.blueAccent : Colors.grey,
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
            const SnackBar(content: Text('Item added to cart!')),
          );
        },
        text: 'Add to Cart',
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        color: Colors.blue,
        textColor: Colors.white,
        shape: GFButtonShape.pills,
        size: GFSize.LARGE,
      ),
    );
  }
}