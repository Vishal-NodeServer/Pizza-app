import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../../../../../../theme/style.dart';
import 'cart_provider.dart'; // Adjust path as needed

class FoodDetailPage extends StatefulWidget {
  final Map<String, String> data;

  const FoodDetailPage({super.key, required this.data});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int _quantity = 1;
  double get price =>
      double.tryParse(widget.data['price'] ?? '0') ??
      0; // Fetch price from data map

  double get total => price * _quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomWidget(),
      appBar: AppBar(
        backgroundColor: whiteColor,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Image.asset(
                "assets/${widget.data['image']}",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 15),
            _selectQuantityWidget(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.data['title']}",
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    const SizedBox(width: 5),
                    Text("${widget.data['rating']}")
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text("Chicken breast, french fries, baked potato wedges."),
            const SizedBox(height: 15),
            const Row(
              children: [
                Icon(Icons.calendar_today, color: primaryColorED6E1B),
                SizedBox(width: 10),
                Text("FREE delivery Sunday")
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                Icon(Icons.location_on, color: primaryColorED6E1B),
                SizedBox(width: 10),
                Text("Delivery within 30 min")
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _selectQuantityWidget() {
    return Center(
      child: Container(
        width: 130,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: lightGreyColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              spreadRadius: 1.5,
              blurRadius: 5.5,
              color: Colors.grey[400]!,
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: _decrementQuantity,
              child: const Icon(Icons.remove_outlined),
            ),
            const SizedBox(width: 10),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColorED6E1B,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(
                child: Text(
                  "$_quantity",
                  style: const TextStyle(fontSize: 15, color: whiteColor),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: _incrementQuantity,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _bottomWidget() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(5, -2),
            color: Colors.grey[300]!,
            spreadRadius: 1.5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "₹ ${total.toStringAsFixed(2)}", // Updated total calculation
              style: const TextStyle(fontSize: 16),
            ),
            ButtonContainerWidget(
              width: 150,
              height: 40,
              title: "Add to cart",
              onTap: () {
                final cart = Provider.of<CartProvider>(context, listen: false);
                cart.addItem(
                  CartItem(
                    title: widget.data['title']!,
                    image: widget.data['image']!,
                    price: price, // Use the actual price from the data
                    quantity: _quantity,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Item added to cart")));
                Navigator.pop(context);
              },
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}

// Define the ButtonContainerWidget directly in the same file
class ButtonContainerWidget extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final VoidCallback onTap;
  final Color color;

  const ButtonContainerWidget({
    super.key,
    this.width = double.infinity,
    this.height = 50.0,
    required this.title,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
