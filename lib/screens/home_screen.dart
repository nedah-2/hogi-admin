import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/global_variables.dart';
import 'package:hogi_milk_admin/models/constant.dart';
import 'package:hogi_milk_admin/screens/home/cancelled_screen.dart';
import 'package:hogi_milk_admin/screens/home/delivery_screen.dart';
import 'package:hogi_milk_admin/screens/home/order_screen.dart';
import 'package:hogi_milk_admin/screens/setting/change_options.dart';
import 'package:hogi_milk_admin/screens/setting/change_photo.dart';

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
    return SizedBox(
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
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(
        'HOGI',
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.bold),
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
                //log out
              }
            },
            icon: const Icon(Icons.settings),
            itemBuilder: (context) =>
                ['Change Photo', 'Change Options', 'Log Out'].map((option) {
                  return PopupMenuItem(
                      value: option,
                      child: ListTile(
                        leading: Icon(iconOptions[option]),
                        title: Text(option),
                      ));
                }).toList())
      ],
    );
  }
}
