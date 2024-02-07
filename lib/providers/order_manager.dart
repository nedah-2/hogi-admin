import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../models/order.dart';

class OrderManager with ChangeNotifier{
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  List<Order> orders = [];

  List<Order> get getAllOrders{
    return [...orders];
  }

  List<Order> get getAllCancelledOrders{
    return [...orders.where((o) => o.status == OrderStatus.cancelled)];
  }

  List<Order> get getAllDeliveredOrders{
    return [...orders.where((o) => o.status == OrderStatus.delivered)];
  }

  Future<void> createOrder(Order order) async {
    final newRef = _database.ref('orders').push();
    order.id = newRef.key!;
    await newRef.set(order.toJson());
    orders.add(order);
    notifyListeners();
  }

  Future<void> updateOrderStatus(String orderId,String newStatus) async {
    final ref = _database.ref('orders').child(orderId);
    await ref.update({'status' : newStatus});
    int existingIndex = orders.indexWhere((o) => o.id == orderId);
    orders[existingIndex].status = newStatus;
    notifyListeners();
  }

  Future<void> deleteOrder(String orderId)async {
    int existingIndex = orders.indexWhere((o) => o.id == orderId);
    final ref = _database.ref('orders').child(orderId);
    await ref.remove();
    orders.removeAt(existingIndex);
    notifyListeners();
  }
}