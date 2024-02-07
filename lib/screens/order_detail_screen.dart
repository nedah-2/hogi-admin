import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/models/constant.dart';

final statusColor = {
  'Pending': pendingColor,
  'Cancelled': dangerColor,
  'Confirmed': successColor
};

const String orderStatus = 'Pending';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Order Detail')),
      body: ListView(
        children: [
          buildInfoTile(title: 'Name', content: 'U Mg Mg Aye'),
          buildInfoTile(title: 'Phone Number', content: '09738728393'),
          buildInfoTile(title: 'Quantity', content: '3 Items'),
          buildInfoTile(
              title: 'Address',
              content: 'No.32, U Shwe Kaung Street, Yan Kin Township, Yangon'),
          buildInfoTile(title: 'Order Date', content: 'Friday,Jan 10,2024'),
          ListTile(
            title: const Text('Order Status',
                style: const TextStyle(color: Colors.black54)),
            subtitle: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ['Pending', 'Cancelled', 'Confirmed'].map((status) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: status == orderStatus
                            ? statusColor[status]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      status,
                      style: TextStyle(
                          color: status == orderStatus
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
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
