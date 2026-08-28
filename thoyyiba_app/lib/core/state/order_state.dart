import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DummyOrder {
  final String orderId;
  final String date;
  final String location;
  final String statusLabel;
  final String productName;
  final String imageUrl;
  final int qty;
  final int productPrice;
  final int shippingPrice;
  final String shippingType;

  const DummyOrder({
    required this.orderId,
    required this.date,
    required this.location,
    required this.statusLabel,
    required this.productName,
    required this.imageUrl,
    required this.qty,
    required this.productPrice,
    required this.shippingPrice,
    required this.shippingType,
  });

  int get subtotal => productPrice * qty;
  int get total => subtotal + shippingPrice;

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'date': date,
      'location': location,
      'statusLabel': statusLabel,
      'productName': productName,
      'imageUrl': imageUrl,
      'qty': qty,
      'productPrice': productPrice,
      'shippingPrice': shippingPrice,
      'shippingType': shippingType,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  factory DummyOrder.fromMap(Map<String, dynamic> map) {
    return DummyOrder(
      orderId: map['orderId'] ?? '',
      date: map['date'] ?? '',
      location: map['location'] ?? '',
      statusLabel: map['statusLabel'] ?? '',
      productName: map['productName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      qty: map['qty']?.toInt() ?? 1,
      productPrice: map['productPrice']?.toInt() ?? 0,
      shippingPrice: map['shippingPrice']?.toInt() ?? 0,
      shippingType: map['shippingType'] ?? '',
    );
  }
}

class OrderState {
  static final ValueNotifier<List<DummyOrder>> orders = ValueNotifier([]);
  static StreamSubscription<QuerySnapshot>? _orderSubscription;

  static void listenToOrders(String userId) {
    _orderSubscription?.cancel();
    _orderSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      final List<DummyOrder> loadedOrders = [];
      for (var doc in snapshot.docs) {
        loadedOrders.add(DummyOrder.fromMap(doc.data()));
      }
      orders.value = loadedOrders;
    });
  }

  static void stopListening() {
    _orderSubscription?.cancel();
    _orderSubscription = null;
    orders.value = [];
  }

  static Future<void> addOrder(DummyOrder order) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .doc(order.orderId)
          .set(order.toMap());
    } else {
      final updatedList = List<DummyOrder>.from(orders.value);
      updatedList.insert(0, order);
      orders.value = updatedList;
    }
  }

  static Future<void> removeOrder(String orderId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .doc(orderId)
          .delete();
    } else {
      final updatedList = List<DummyOrder>.from(orders.value);
      updatedList.removeWhere((o) => o.orderId == orderId);
      orders.value = updatedList;
    }
  }
}
