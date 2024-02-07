import 'package:flutter/material.dart';
class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key});

  Widget buildOrderCard() {
    return Padding(
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
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(8))
              ),
            ),
            const Expanded(
              child: ListTile(
                title: Text('U Mg Mg'),
                subtitle: Text('09123456789'),
                trailing: Text('3 Items'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 20,
        padding: const EdgeInsets.only(top: 20,bottom: 20),
        shrinkWrap: true,
        itemBuilder: (context,index){
          return buildOrderCard();
        }
    );
  }
}
