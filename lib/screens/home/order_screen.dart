import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../widgets/order_card.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.orders});
  final List<Order> orders;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orders.length,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return OrderCard(order: orders[index]);
        });
  }
}
