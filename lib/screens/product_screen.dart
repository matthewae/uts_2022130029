import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_2022130029/utils/cart_manager.dart';

class ProductScreen extends StatefulWidget {
  final String productName;
  final Map<String, Map<String, String>> productDetails;

  const ProductScreen({super.key, required this.productName, required this.productDetails});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.productDetails[widget.productName];
    final description = product?['description'] ?? 'Deskripsi tidak tersedia.';
    final price = product?['price'] ?? 'Harga tidak tersedia.';
    final imageUrl = product?['imageUrl'] ?? 'https://via.placeholder.com/150';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
        elevation: 0, 
        backgroundColor: Colors.deepPurple, 
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              height: 250, 
              width: double.infinity,
              color: Colors.grey[200],
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            
            Card(
              margin: const EdgeInsets.all(16.0),
              elevation: 5, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName,
                      style: const TextStyle(
                        fontSize: 30, // ukuran font
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ), 
                    ),
                    const SizedBox(height: 10),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Divider(height: 30, thickness: 1), // divider
                    Text(
                      description,
                      style: const TextStyle(fontSize: 17, color: Colors.black87, height: 1.5), // Adjusted line height
                      textAlign: TextAlign.justify, 
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, color: Colors.deepPurple),
                                onPressed: _decrementQuantity,
                              ),
                              Text(
                                '$_quantity',
                                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, color: Colors.deepPurple),
                                onPressed: _incrementQuantity,
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            final cartManager = Provider.of<CartManager>(context, listen: false);
                            final String productId = widget.productName; 
                            final String name = widget.productName;
                            final double itemPrice = double.parse(price.replaceAll('Rp ', '').replaceAll('.', ''));
                            final String imageUrl = product?['imageUrl'] ?? 'https://via.placeholder.com/150';

                            cartManager.addItem(productId, name, itemPrice, imageUrl);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${widget.productName} x $_quantity ditambahkan ke keranjang!')),
                            );
                            Navigator.of(context).pushNamed('/cart'); // Navigasi ke CartScreen
                          },
                          icon: const Icon(Icons.shopping_cart, color: Colors.white), // icon
                          label: const Text('Add to cart', style: TextStyle(fontSize: 17, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple, 
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14), 
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3, 
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}