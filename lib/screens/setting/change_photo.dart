import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/models/constant.dart';
import 'package:hogi_milk_admin/providers/promote_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_button.dart';

class ChangePhoto extends StatefulWidget {
  const ChangePhoto({super.key});

  @override
  State<ChangePhoto> createState() => _ChangePhotoState();
}

class _ChangePhotoState extends State<ChangePhoto> {
  late Future imageFuture;
  Future<void> obtainFuture(){
    return Provider.of<PromoteProvider>(context,listen: false).fetchImageUrls();
  }
  final List<ImagePicker> pickers = [ImagePicker(),ImagePicker()];

  @override
  void initState() {
    // TODO: implement initState
    imageFuture = obtainFuture();
    super.initState();
  }
  Future _pickImage(PromoteProvider provider,int index) async {
    XFile? file = await pickers[index].pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (file == null) {
      return;
    }
    provider.setPickedFile(index, file);
  }

  Widget buildImageFrame(String title,PromoteProvider provider,int index){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title,style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: ()=> _pickImage(provider, index),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  provider.pickedFiles[index] == null ?
                  provider.imageUrls[index].isNotEmpty ?
                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(10),
                    child: Image.network(provider.imageUrls[index],height: 300,fit: BoxFit.fill),
                  )
                      :
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(Radius.circular(20))),
                      height: 300,
                      child: const Text('Choose Image')
                  ) : ClipRRect(
                    borderRadius:
                    BorderRadius.circular(10),
                    child: Image.file(
                      File(provider.pickedFiles[index]!.path),
                      fit: BoxFit.fill,
                      height: 300,
                    ),
                  ),
                  Card(
                    elevation: 0.1,
                    color: Colors.white.withOpacity(0.1),
                    surfaceTintColor: Colors.transparent,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Choose New Image',style: TextStyle(color: Colors.white),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Photo'), centerTitle: true),
      body: FutureBuilder(
        future: imageFuture,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else{
            return Consumer<PromoteProvider>(
                builder: (context,data,child){
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            buildImageFrame('Top',data,0),
                            buildImageFrame('Bottom',data,1)
                          ],
                        ),
                        CustomButton(
                            label: 'Save Changes',
                            onPressed: () async {
                              if(data.pickedFiles[0] == null && data.pickedFiles[1] == null){
                                showMessage(context, 'Choose an image to save changes');
                              }else{
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => const Center(
                                        child: CircularProgressIndicator(color: Colors.deepOrangeAccent)));
                                await data.saveChanges().then((value){
                                  Navigator.of(context).pop();
                                  showMessage(context, 'Changes Saved');
                                });
                              }
                            }
                        )
                      ],
                    ),
                  );
                }
            );
          }
        },
      ),
    );
  }
}
