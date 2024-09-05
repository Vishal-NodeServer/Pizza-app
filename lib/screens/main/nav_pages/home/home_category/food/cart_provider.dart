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
    final existingItemIndex = _items.indexWhere((i) => i.title == item.title);
    if (existingItemIndex != -1) {
      // If item already exists, update quantity
      _items[existingItemIndex].quantity += item.quantity;
    } else {
      // If item doesn't exist, add new item
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
