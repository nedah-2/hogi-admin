import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../models/order.dart';

class OrderManager with ChangeNotifier {
  static final FirebaseDatabase _database = FirebaseDatabase.instance;
  final orderRef = _database.ref('orders');

  List<Order> orders = [];

  List<Order> getFoundOrder(String query) {
    return [
      ...orders.reversed
          .where((o) =>
              o.name.toLowerCase().contains(query) ||
              o.phone.toLowerCase().contains(query))
          .toList()
    ];
  }

  List<Order> get getAllOrders {
    return [...orders.reversed];
  }

  List<Order> get getAllCancelledOrders {
    return [...orders.reversed.where((o) => o.status == OrderStatus.cancelled)];
  }

  List<Order> get getAllDeliveryOrders {
    return [
      ...orders.reversed.where((o) => o.status == OrderStatus.confirmed),
      ...orders.reversed
          .where((o) => o.status == OrderStatus.delivered)
          .toList()
    ];
  }

  void setDataFromSnapshot(List<Order> items) {
    orders.clear();
    orders = items;
  }

  Future<void> fetchOrders() async {
    orders.clear();
    orderRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value == null) {
        return;
      }
      final data = event.snapshot.value;
      Map<dynamic, dynamic> orderData = data as Map<dynamic, dynamic>;
      orderData.forEach((key, value) {
        orders.add(Order.fromJson(key, Map<String, dynamic>.from(value)));
      });
    });

    notifyListeners();
  }

  Future<void> createOrder(Order order) async {
    final newRef = _database.ref('orders').push();
    order.id = newRef.key!;

    await newRef.set(order.toJson());
    //orders.add(order);
    //notifyListeners();
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    final ref = _database.ref('orders').child(orderId);
    await ref.update({'status': newStatus});
    int existingIndex = orders.indexWhere((o) => o.id == orderId);
    orders[existingIndex].status = newStatus;
    notifyListeners();
  }

  Future<void> deleteOrder(String orderId) async {
    int existingIndex = orders.indexWhere((o) => o.id == orderId);
    final ref = _database.ref('orders').child(orderId);
    await ref.remove();
    orders.removeAt(existingIndex);
    notifyListeners();
  }

  Order getOrderById(String orderId) {
    int existingIndex = orders.indexWhere((o) => o.id == orderId);
    return orders[existingIndex];
  }
}
