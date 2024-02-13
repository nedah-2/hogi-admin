import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class PromoteProvider with ChangeNotifier {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  List<String> imageUrls = [];
  List<XFile?> pickedFiles = [];

  List<String> get getImageUrls {
    return imageUrls;
  }

  // Function to determine content type based on file extension
  String _getContentType(String filePath) {
    if (filePath.toLowerCase().endsWith('.png')) {
      return 'image/png';
    } else if (filePath.toLowerCase().endsWith('.jpg') ||
        filePath.toLowerCase().endsWith('.jpeg')) {
      return 'image/jpeg';
    } else {
      // You can handle other image formats here or use a default content type
      return 'application/octet-stream'; // Default to binary if unknown
    }
  }

  Future<void> fetchImageUrls() async {
    final snapshot = await _database.ref('images').get();
    var data = snapshot.value as Map;
    for (String d in data.values.toList()) {
      imageUrls.add(d == "default" ? '' : d);
    }
    pickedFiles = [null, null];

    notifyListeners();
  }

  void setImageUrl(int index, String imageUrl) {
    imageUrls[index] = imageUrl;
    notifyListeners();
  }

  void setPickedFile(int index, XFile? file) {
    pickedFiles[index] = file;
    notifyListeners();
  }

  Future<void> saveChanges() async {
    final ref = storage.FirebaseStorage.instance.ref().child('images');
    final databaseRef = _database.ref('images');
    List.generate(2, (index) async {
      if (pickedFiles[index] != null) {
        final imgRef = ref.child(DateTime.now().toIso8601String() +
            p.basename(pickedFiles[index]!.path));
        final String contentType = _getContentType(pickedFiles[index]!.path);
        final result = await imgRef.putFile(
          File(pickedFiles[index]!.path),
          storage.SettableMetadata(
            contentType: contentType,
            cacheControl: 'max-age=3600',
          ),
        );
        final downloadUrl = await result.ref.getDownloadURL();

        if (imageUrls[index].isNotEmpty) {
          try {
            await FirebaseStorage.instance
                .refFromURL(imageUrls[index])
                .delete();
          } catch (e) {
            debugPrint(e as String?);
          }
        }
        imageUrls[index] = downloadUrl;
        await databaseRef.child('img${index + 1}').set(downloadUrl);
      }
    });

    //pickedFiles = [null, null];
    notifyListeners();
  }
}
