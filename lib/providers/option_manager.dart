import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../models/option.dart';

class OptionManager with ChangeNotifier{

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Option> options = [];

  List<Option> get getAllOptions{
    return [...options];
  }

  Future<void> createOption(Option option) async {
    final ref = _database.ref('options').push();
    option.id = ref.key!;
    await ref.set(option.toJson());
    options.add(option);
    notifyListeners();
  }

  Future<void> updateOption(String optionId,Map<String,dynamic> updatedFields) async {
    final ref = _database.ref('options').child(optionId);
    await ref.update(updatedFields);
    int existingIndex = options.indexWhere((o) => o.id == optionId);
    Option updatedOption = Option.fromJson(optionId, updatedFields);
    options[existingIndex] = updatedOption;
    notifyListeners();
  }

  Future<void> deleteOption(String optionId)async {
    int existingIndex = options.indexWhere((o) => o.id == optionId);
    final ref = _database.ref('options').child(optionId);
    await ref.remove();
    options.removeAt(existingIndex);
    notifyListeners();
  }


}