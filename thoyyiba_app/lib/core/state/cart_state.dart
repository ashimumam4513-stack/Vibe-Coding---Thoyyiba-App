import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final String price; // e.g. 'Rp 450.000'
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  int get priceValue {
    // Parse 'Rp 450.000' -> 450000
    final numericOnly = price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numericOnly) ?? 0;
  }
}

class CartState {
  static final ValueNotifier<List<CartItem>> items = ValueNotifier([]);

  static void addItem(CartItem item) {
    final currentItems = List<CartItem>.from(items.value);
    final existingIndex = currentItems.indexWhere((i) => i.id == item.id);
    
    if (existingIndex >= 0) {
      currentItems[existingIndex].quantity += 1;
    } else {
      currentItems.add(item);
    }
    
    items.value = currentItems;
  }

  static void removeItem(String id) {
    final currentItems = List<CartItem>.from(items.value);
    currentItems.removeWhere((i) => i.id == id);
    items.value = currentItems;
  }

  static void clearCart() {
    items.value = [];
  }

  static void updateQuantity(String id, int change) {
    final currentItems = List<CartItem>.from(items.value);
    final index = currentItems.indexWhere((i) => i.id == id);
    if (index >= 0) {
      final newQuantity = currentItems[index].quantity + change;
      if (newQuantity > 0) {
        currentItems[index].quantity = newQuantity;
      } else {
        currentItems.removeAt(index);
      }
      items.value = currentItems;
    }
  }

  static int get totalItems {
    return items.value.fold(0, (sum, item) => sum + item.quantity);
  }
  
  static int get subtotal {
    return items.value.fold(0, (sum, item) => sum + (item.priceValue * item.quantity));
  }
  
  static String get formattedSubtotal {
    final formatter = subtotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
    return 'Rp $formatter';
  }
}
