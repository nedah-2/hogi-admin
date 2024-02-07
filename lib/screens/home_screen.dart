import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/global_variables.dart';
import 'package:hogi_milk_admin/models/constant.dart';
import 'package:hogi_milk_admin/models/order.dart';
import 'package:hogi_milk_admin/providers/auth_manager.dart';
import 'package:hogi_milk_admin/providers/order_manager.dart';
import 'package:hogi_milk_admin/screens/home/cancelled_screen.dart';
import 'package:hogi_milk_admin/screens/home/delivery_screen.dart';
import 'package:hogi_milk_admin/screens/search_order.dart';
import 'package:hogi_milk_admin/screens/setting/change_options.dart';
import 'package:hogi_milk_admin/screens/setting/change_photo.dart';
import 'package:provider/provider.dart';
import 'home/order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const iconOptions = {
  'Change Photo': Icons.image,
  'Change Options': Icons.list,
  'Log Out': Icons.logout
};

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final screens = const [OrderScreen(), CancelledScreen(), DeliveryScreen()];

  _HomeScreenState() {
    // subscribe to the message stream fed by foreground message handler
    messageStreamController.listen((message) {
      setState(() {
        if (message.notification != null) {
          print('Received a notification message');
        } else {
          print('Received a data message: ${message.data}');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [buildSearchBar(), screens[currentIndex]],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        currentIndex: currentIndex,
        selectedItemColor: [confirmColor,dangerColor,successColor][currentIndex],
        onTap: (newIndex) => setState(() => currentIndex = newIndex),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: 'Cancelled'),
          BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining), label: 'Delivery'),
        ],
      ),
    );
  }

  Widget buildSearchBar() {
    return GestureDetector(
      onTap: ()=> showSearch(context: context, delegate: SearchOrder()),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          surfaceTintColor: Colors.white,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              'Search Customer...',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final provider = Provider.of<OrderManager>(context,listen: false);
    return AppBar(
      centerTitle: false,
      title: GestureDetector(
        onTap: (){
          Random random = Random();
          Order newOrder = Order(
              id: '1234',
              name: demoItems[random.nextInt(demoItems.length)],
              phone: random.nextInt(100000000).toString(),
              address: 'No.32, U Shwe Kaung Street, Yan Kin Township, Yangon',
              count: random.nextInt(10).toString(),
              totalPrice: '${random.nextInt(10000)} MMK',
              date: '${DateTime.now()}',
              status: [OrderStatus.ordered,OrderStatus.confirmed,OrderStatus.cancelled,OrderStatus.delivered][random.nextInt(4)]
          );
          provider.createOrder(newOrder);
        },
        child: Text(
          'HOGI',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
      ),
      actions: [
        PopupMenuButton<String>(
            surfaceTintColor: Colors.white,
            onSelected: (String option) {
              switch (option) {
                case 'Change Photo':
                  gotoScreen(context, const ChangePhoto());
                  break;
                case 'Change Options':
                  gotoScreen(context, const ChangeOptions());
                  break;
                default:
                  Provider.of<AuthManager>(context, listen: false).signOut();
              }
            },
            icon: Icon(Icons.settings,color: Theme.of(context).primaryColor),
            itemBuilder: (context) =>
                ['Change Photo', 'Change Options', 'Log Out'].map((option) {
                  return PopupMenuItem(
                    value: option,
                    child: ListTile(
                      leading: Icon(iconOptions[option]),
                      title: Text(option),
                    ),
                  );
                }).toList())
      ],
    );
  }
}
