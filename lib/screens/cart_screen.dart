import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uts_2022130029/utils/cart_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? _selectedItemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Consumer<CartManager>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Text("Keranjang Anda kosong.", style: TextStyle(fontSize: 18)),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.itemCount,
                  itemBuilder: (context, index) {
                    final cartItem = cart.items.values.toList()[index];
                    final isSelected = _selectedItemId == cartItem.id;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedItemId = isSelected ? null : cartItem.id;
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 2,
                        color: isSelected ? Colors.deepPurple.shade50 : null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Image.asset(
                                  cartItem.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.name,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Rp ${cartItem.price.toStringAsFixed(0).replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}',
                                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                    if (isSelected) ...[
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove_circle_outline),
                                            onPressed: () {
                                              cart.decreaseItemQuantity(cartItem.id);
                                            },
                                          ),
                                          Text(
                                            '${cartItem.quantity}',
                                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add_circle_outline),
                                            onPressed: () {
                                              cart.addItem(cartItem.id, cartItem.name, cartItem.price, cartItem.imageUrl);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              cart.removeItem(cartItem.id);
                                              setState(() {
                                                _selectedItemId = null; // remove selection
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              Text(
                                'Rp ${(cartItem.price * cartItem.quantity).toStringAsFixed(0).replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat Pengiriman: ${cart.shippingAddress ?? 'Belum diatur'}' ,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal:', style: TextStyle(fontSize: 16)),
                        Text('Rp ${cart.subtotal.toStringAsFixed(0).replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Pajak (10%):', style: TextStyle(fontSize: 16)),
                        Text('Rp ${cart.tax.toStringAsFixed(0).replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Rp ${cart.total.toStringAsFixed(0).replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (cart.itemCount > 0) {
                            final shippingAddress = cart.shippingAddress ?? 'alamat tidak diketahui';
                            cart.clearCart();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Pesanan Dikonfirmasi!'),
                                  content: Text('Pesanan Anda akan dikirim ke $shippingAddress'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            setState(() {
                              _selectedItemId = null; // remove selection after checkout
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Keranjang Kosong'),
                                  content: const Text('Keranjang Anda kosong. Tambahkan item terlebih dahulu.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Checkout', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}