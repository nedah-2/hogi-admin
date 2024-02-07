import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/models/order.dart';

Color successColor = Colors.teal;
Color pendingColor = Colors.blue;
Color warningColor = Colors.orange;
Color dangerColor = Colors.red;
Color confirmColor = Colors.green;

Map<String,Color> colors = {
  OrderStatus.ordered : pendingColor,
  OrderStatus.cancelled : dangerColor,
  OrderStatus.confirmed : confirmColor,
  OrderStatus.delivered : successColor
};

List<String> demoItems = [
  'Galaxy Horizon',
  'Lumina Edge',
  'Pixel Pro',
  'Nebula Nexus',
  'Quantum Q1',
  'Zenith ZenFone',
  'Astra Alpha',
  'Vortex V1',
  'Nova N1',
  'Cosmo Connect',
];

void gotoScreen(BuildContext context,Widget screen){
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => screen)
  );
}

void showMessage(BuildContext context,String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message),backgroundColor: successColor)
  );
}

String formatAmount(String text){
  String price = text;
  String priceInText = "";
  int counter = 0;
  for(int i = (price.length - 1);  i >= 0; i--){
    counter++;
    String str = price[i];
    if((counter % 3) != 0 && i !=0){
      priceInText = "$str$priceInText";
    }else if(i == 0 ){
      priceInText = "$str$priceInText";

    }else{
      priceInText = ",$str$priceInText";
    }
  }
  return priceInText.trim();
}

