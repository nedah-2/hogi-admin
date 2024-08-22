import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/constant.dart';
import '../models/order.dart';
import '../providers/order_manager.dart';
import '../screens/order_detail_screen.dart';

// ignore: must_be_immutable
class OrderCard extends StatelessWidget {
  OrderCard(
      {super.key,
      required this.order,
      this.isCancelled = false,
      this.isDelivery = false});
  final Order order;
  bool isCancelled;
  bool isDelivery;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => gotoScreen(context, OrderDetailScreen(orderId: order.id)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Card(
          surfaceTintColor: Colors.white,
          elevation: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 10,
                height: 75,
                decoration: BoxDecoration(
                    color: colors[order.status],
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(8))),
              ),
              Expanded(
                child: ListTile(
                  title: Text(order.name),
                  subtitle: Text(order.phone),
                  trailing: isCancelled
                      ? CircleAvatar(
                          backgroundColor: Colors.red,
                          child: IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          title: const Text('Deletion Alert'),
                                          content: const Text(
                                              'Are you sure you want to delete this order?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text('No')),
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  await Provider.of<
                                                              OrderManager>(
                                                          context,
                                                          listen: false)
                                                      .deleteOrder(order.id)
                                                      .then((value) {
                                                    showMessage(context,
                                                        'Order Deleted');
                                                  });
                                                },
                                                child: Text(
                                                  'Yes',
                                                  style: TextStyle(
                                                      color: dangerColor),
                                                )),
                                          ],
                                        ));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              )),
                        )
                      : isDelivery
                          ? ElevatedButton(
                              onPressed: order.status == OrderStatus.delivered
                                  ? null
                                  : () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                backgroundColor: Colors.white,
                                                surfaceTintColor: Colors.white,
                                                title: const Text(
                                                    'Update Status Alert'),
                                                content: const Text(
                                                    'Are you sure you want to mark this order as delivered?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: const Text('No')),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await Provider.of<
                                                                    OrderManager>(
                                                                context,
                                                                listen: false)
                                                            .updateOrderStatus(
                                                                order.id,
                                                                OrderStatus
                                                                    .delivered)
                                                            .then((value) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          showMessage(context,
                                                              'Order Status Updated');
                                                        });
                                                      },
                                                      child: Text(
                                                        'Yes',
                                                        style: TextStyle(
                                                            color: dangerColor),
                                                      )),
                                                ],
                                              ));
                                    },
                              style: ElevatedButton.styleFrom(
                                  disabledBackgroundColor: successColor,
                                  disabledForegroundColor: Colors.white,
                                  fixedSize: const Size(120, 40),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  backgroundColor:
                                      order.status == OrderStatus.confirmed
                                          ? confirmColor
                                          : successColor,
                                  // surfaceTintColor:order.status == OrderStatus.confirmed ? confirmColor : successColor ,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text(order.status))
                          : Text('${order.count} Items'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
