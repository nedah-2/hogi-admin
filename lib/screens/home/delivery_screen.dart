import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/order_manager.dart';
import '../../widgets/order_card.dart';
import '../../widgets/empty_widget.dart';
class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderManager>(
      builder: (context,data,child){
        return data.getAllDeliveryOrders.isEmpty ? const EmptyWidget() : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.getAllDeliveryOrders.length,
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            shrinkWrap: true,
            itemBuilder: (context,index){
              return OrderCard(order: data.getAllDeliveryOrders[index],isDelivery: true);
            }
        );
      },
    );
  }
}
