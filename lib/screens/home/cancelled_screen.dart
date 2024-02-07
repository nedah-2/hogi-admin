import 'package:flutter/material.dart';

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({super.key});

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
            Expanded(
              child: ListTile(
                title: const Text('U Mg Mg'),
                subtitle: const Text('09123456789'),
                trailing: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(onPressed: (){}, icon: const Icon(Icons.delete,color: Colors.white,)),
                ),
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
