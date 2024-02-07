import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../models/constant.dart';
import '../models/option.dart';

class OptionManager with ChangeNotifier{

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Option> options = [];

  List<TextEditingController>  countControllers = [];
  List<TextEditingController> priceControllers = [];

  List<Option> get getAllOptions{
    return [...options];
  }

  Future<void> fetchOptions() async {
    options.clear();
    countControllers.clear();
    priceControllers.clear();
    final snapshot = await _database.ref('options').get();
    final data = snapshot.value as List<dynamic>;

    for (var element in data) {
        options.add(Option(count: element['count'], price: element['price']));
    }

    countControllers = List.generate(options.length, (index) => TextEditingController(text: formatAmount(options[index].count.toString())));
    priceControllers = List.generate(options.length, (index) => TextEditingController(text: formatAmount(options[index].price.toString())));
    notifyListeners();
  }

  Future<void> saveOptions() async{
    final ref =  _database.ref('options');
    await ref.set(
      [
        for(int i = 0;i < countControllers.length ; i++)
          Option(count: int.parse(countControllers[i].text.trim()), price: int.parse(priceControllers[i].text.trim().replaceAll(',',''))).toJson()
      ]
    );

    notifyListeners();
  }

  void addNewController(){
    countControllers.add(TextEditingController());
    priceControllers.add(TextEditingController());
    notifyListeners();
  }



  deleteController(int index){
    countControllers.removeAt(index);
    priceControllers.removeAt(index);
    notifyListeners();
  }
}