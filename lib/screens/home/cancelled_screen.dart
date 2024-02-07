import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/providers/order_manager.dart';
import 'package:hogi_milk_admin/widgets/order_card.dart';
import 'package:provider/provider.dart';

import '../../models/constant.dart';
import '../../models/order.dart';
import '../order_detail_screen.dart';
import '../../widgets/empty_widget.dart';

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderManager>(
      builder: (context,data,child){
        return data.getAllCancelledOrders.isEmpty ? const EmptyWidget() : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.getAllCancelledOrders.length,
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            shrinkWrap: true,
            itemBuilder: (context,index){
              return OrderCard(order: data.getAllCancelledOrders[index],isCancelled: true);
            }
        );
      },
    );
  }
}
