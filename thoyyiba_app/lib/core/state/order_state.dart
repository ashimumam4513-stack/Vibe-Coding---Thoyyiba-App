import 'package:flutter/material.dart';

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
}

class OrderState {
  static final ValueNotifier<List<DummyOrder>> orders = ValueNotifier([]);

  static void addOrder(DummyOrder order) {
    final updatedList = List<DummyOrder>.from(orders.value);
    updatedList.insert(0, order); // add to top
    orders.value = updatedList;
  }

  static void removeOrder(String orderId) {
    final updatedList = List<DummyOrder>.from(orders.value);
    updatedList.removeWhere((o) => o.orderId == orderId);
    orders.value = updatedList;
  }
}

