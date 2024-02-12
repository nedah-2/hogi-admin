import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../providers/order_manager.dart';
import '../../widgets/order_card.dart';
import '../../widgets/empty_widget.dart';
class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key,required this.orders});
  final List<Order> orders;
  @override
  Widget build(BuildContext context) {
    return orders.isEmpty ? const EmptyWidget() : ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orders.length,
        padding: const EdgeInsets.only(top: 20,bottom: 20),
        shrinkWrap: true,
        itemBuilder: (context,index){
          return OrderCard(order: orders[index],isDelivery: true);
        }
    );
  }
}
