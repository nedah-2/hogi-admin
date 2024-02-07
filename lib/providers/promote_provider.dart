import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class PromoteProvider with ChangeNotifier{
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  List<String> imageUrls = [];
  List<XFile?> pickedFiles = [];

  List<String> get getImageUrls{
    return imageUrls;
  }

  Future<void> fetchImageUrls() async {
    final snapshot = await _database.ref('images').get();
    var data = snapshot.value as Map;
    for(String d in data.values.toList()){
      imageUrls.add(d == "default" ? '' : d);
      print(d);
    }
    pickedFiles = [null,null];

    notifyListeners();
  }

  void setImageUrl(int index,String imageUrl){
    imageUrls[index] = imageUrl;
    notifyListeners();
  }

  void setPickedFile(int index,XFile? file){
    pickedFiles[index] = file;
    notifyListeners();
  }

  Future<void> saveChanges() async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('images');
    final databaseRef = _database.ref('images');
    List.generate(2, (index) async {
      if(pickedFiles[index] != null){
        final imgRef = ref.child(DateTime.now().toIso8601String() + p.basename(pickedFiles[index]!.path));
        final result = await imgRef.putFile(File(pickedFiles[index]!.path));
        final downloadUrl = await result.ref.getDownloadURL();
        print('downloadURL: $downloadUrl');

        if(imageUrls[index].isNotEmpty){
          try{
            await FirebaseStorage.instance
                .refFromURL(imageUrls[index])
                .delete();
          }catch(e){
            print(e);
          }
        }
        imageUrls[index] = downloadUrl;
        await databaseRef.child('img${index + 1}').set(downloadUrl);
      }
    });

    pickedFiles = [null,null];
    notifyListeners();
  }
}