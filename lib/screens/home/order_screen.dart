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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderManager>(context,listen: false);
    return StreamBuilder(
        stream: provider.orderRef.onValue,
      builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          else{
            provider.setDataFromSnapshot(snapshot.data!.snapshot);
            return Consumer<OrderManager>(
                builder: (context,data,child){
                  return data.orders.isEmpty ? const EmptyWidget(): ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.getAllOrders.length,
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return OrderCard(order: data.getAllOrders[index]);
                      }
                  );
                }
            );
          }
      },
    );
  }
}
