import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get total {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void addItem(CartItem item) {
    final existingItem = _items.firstWhere(
      (i) => i.title == item.title,
      orElse: () => CartItem(title: '', image: '', price: 0, quantity: 0),
    );
    if (existingItem.title.isNotEmpty) {
      existingItem.quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity > 0) {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }
}
