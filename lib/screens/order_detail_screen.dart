import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/models/constant.dart';
import 'package:hogi_milk_admin/utils/format_date.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../providers/order_manager.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderManager>(builder: (context, data, child) {
      Order order = data.getOrderById(orderId);
      return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Order Detail')),
        body: ListView(
          children: [
            buildInfoTile(title: 'Name', content: order.name),
            buildInfoTile(title: 'Phone Number', content: order.phone),
            buildInfoTile(title: 'Quantity', content: '${order.count} Items'),
            buildInfoTile(title: 'Address', content: order.address),
            buildInfoTile(title: 'Order Date', content: formatDate(order.date)),
            ListTile(
              title: const Text('Order Status',
                  style: TextStyle(color: Colors.black54)),
              subtitle: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['Ordered', 'Cancelled', 'Confirmed', 'Delivered']
                    .map((status) {
                  return GestureDetector(
                    onTap: status == order.status
                        ? null
                        : () async {
                            await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      title: const Text('Update Status Alert'),
                                      content: Text(
                                          'Are you sure you want to mark this order as $status?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('No')),
                                        TextButton(
                                            onPressed: () async {
                                              await Provider.of<OrderManager>(
                                                      context,
                                                      listen: false)
                                                  .updateOrderStatus(
                                                      order.id, status)
                                                  .then((_) {
                                                Navigator.of(context).pop();
                                                showMessage(context,
                                                    'Order Status Updated');
                                              });
                                            },
                                            child: Text(
                                              'Yes',
                                              style:
                                                  TextStyle(color: dangerColor),
                                            )),
                                      ],
                                    ));
                          },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        surfaceTintColor: Colors.transparent,
                        elevation: 0,
                        color: status == order.status
                            ? colors[status]
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            status,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: status == order.status
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      );
    });
  }

  ListTile buildInfoTile({required String title, required String content}) {
    return ListTile(
      isThreeLine: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black54),
      ),
      subtitle: Text(
        content,
        style:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }
}
