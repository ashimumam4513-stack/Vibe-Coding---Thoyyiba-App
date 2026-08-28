import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartItem {
  final String id;
  final String title;
  final String price;
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
    final numericOnly = price.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(numericOnly) ?? 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      price: map['price'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity']?.toInt() ?? 1,
    );
  }
}

class CartState {
  static final ValueNotifier<List<CartItem>> items = ValueNotifier([]);
  static StreamSubscription<QuerySnapshot>? _cartSubscription;

  static void listenToCart(String userId) {
    _cartSubscription?.cancel();
    _cartSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .listen((snapshot) {
      final List<CartItem> loadedItems = [];
      for (var doc in snapshot.docs) {
        loadedItems.add(CartItem.fromMap(doc.data()));
      }
      items.value = loadedItems;
    });
  }

  static void stopListening() {
    _cartSubscription?.cancel();
    _cartSubscription = null;
    items.value = [];
  }

  static Future<void> addItem(CartItem item) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      final currentItems = List<CartItem>.from(items.value);
      final existingIndex = currentItems.indexWhere((i) => i.id == item.id);
      if (existingIndex >= 0) {
        currentItems[existingIndex].quantity += 1;
      } else {
        currentItems.add(item);
      }
      items.value = currentItems;
      return;
    }

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart')
        .doc(item.id);
        
    final docSnap = await docRef.get();
    if (docSnap.exists) {
      await docRef.update({
        'quantity': FieldValue.increment(1),
      });
    } else {
      await docRef.set(item.toMap());
    }
  }

  static Future<void> removeItem(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(id)
          .delete();
    } else {
      final currentItems = List<CartItem>.from(items.value);
      currentItems.removeWhere((i) => i.id == id);
      items.value = currentItems;
    }
  }

  static Future<void> clearCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final cartDocs = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .get();
      for (var doc in cartDocs.docs) {
        await doc.reference.delete();
      }
    }
    items.value = [];
  }

  static Future<void> updateQuantity(String id, int change) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .doc(id);
      final docSnap = await docRef.get();
      if (docSnap.exists) {
        final currentQty = docSnap.data()?['quantity'] ?? 1;
        final newQty = currentQty + change;
        if (newQty > 0) {
          await docRef.update({'quantity': newQty});
        } else {
          await docRef.delete();
        }
      }
    } else {
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
  }

  static int get totalItems {
    return items.value.fold(0, (sum, item) => sum + item.quantity);
  }
  
  static int get subtotal {
    return items.value.fold(0, (sum, item) => sum + (item.priceValue * item.quantity));
  }
  
  static String get formattedSubtotal {
    final formatter = subtotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '\${m[1]}.');
    return 'Rp \$formatter';
  }
}
