import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/screens/main/nav_pages/cart/OrderConfirm.dart';
import 'package:pizza_app/screens/main/nav_pages/home/home_category/food/food_detail_page.dart';
import 'package:provider/provider.dart';
import 'package:pizza_app/screens/main/main_screen.dart';
import 'package:pizza_app/theme/style.dart';
import '../home/home_category/food/cart_provider.dart'; // Adjust path as needed

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final cartItems = cartProvider.items;
        final deliveryFee = 50.00;
        final total = cartProvider.total + deliveryFee;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${cartItems.length} unique items in the cart",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return _itemCartWidget(
                        index: index,
                        item: cartItems[index],
                        cartProvider: cartProvider,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Items",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${cartItems.length}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Delivery Fee",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹${deliveryFee.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[350],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "₹${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ButtonContainerWidget(
                  title: "Checkout",
                  onTap: () async {
                    // Save the cart items to Firestore
                    await _saveOrderToFirestore(cartItems, total, deliveryFee);

                    // Navigate to OrderConfirmedPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => OrderConfirmedPage()),
                    );
                  },
                  color: Colors.yellow,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveOrderToFirestore(
      List<CartItem> cartItems, double total, double deliveryFee) async {
    // Reference to Firestore collection
    final orderRef = FirebaseFirestore.instance.collection('Orders').doc();

    // Prepare order data
    final orderData = {
      'items': cartItems.map((item) {
        return {
          'title': item.title,
          'quantity': item.quantity,
          'price': item.price,
        };
      }).toList(),
      'total': total,
      'deliveryFee': deliveryFee,
      'orderDate': Timestamp.now(),
    };

    try {
      // Add order to Firestore
      await orderRef.set(orderData);
      print("Order saved to Firestore");
    } catch (e) {
      print("Error saving order: $e");
    }
  }

  Widget _itemCartWidget({
    required int index,
    required CartItem item,
    required CartProvider cartProvider,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            spreadRadius: 1.5,
            blurRadius: 6.5,
            color: Colors.grey[300]!,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/${item.image}",
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => cartProvider.removeItem(index),
                      child: Container(
                        width: 30,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: lightGreyColor,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: primaryColorED6E1B,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text("Times Food"),
                const SizedBox(height: 5),
                Text(
                  "₹${item.price.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (item.quantity > 1) {
                          cartProvider.updateQuantity(index, item.quantity - 1);
                        }
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1),
                        ),
                        child: const Center(
                          child: Icon(Icons.remove_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text("${item.quantity}"),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        cartProvider.updateQuantity(index, item.quantity + 1);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1),
                        ),
                        child: const Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
