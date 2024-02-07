import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/models/constant.dart';
import 'package:hogi_milk_admin/providers/order_manager.dart';
import 'package:hogi_milk_admin/widgets/empty_widget.dart';
import 'package:hogi_milk_admin/screens/order_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../models/order.dart';
import '../../widgets/order_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future orderFuture;
  Future<void> obtainOrderFuture(){
    return Provider.of<OrderManager>(context,listen: false).fetchOrders();
  }
  @override
  void initState() {
    // TODO: implement initState
    orderFuture = obtainOrderFuture();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderManager>(context,listen: false);
    return StreamBuilder(
        stream: provider.orderRef.onValue,
      builder: (context,snapshot){
          if(!snapshot.hasData){
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(width: 50,child: LinearProgressIndicator(borderRadius: BorderRadius.all(Radius.circular(10)))),
            );
          }
          else{
            List<Order> orders = [];
            Map<dynamic, dynamic> orderData = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            orderData.forEach((key, value) {
              orders.add(Order.fromJson(key, Map<String, dynamic>.from(value)));
            });

            provider.setDataFromSnapshot(orders);
            return orders.isEmpty ? const EmptyWidget(): ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orders.length,
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return OrderCard(order: orders[index]);
                }
            );
          }
      },
    );
  }
}
