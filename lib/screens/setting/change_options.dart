import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/models/constant.dart';
import 'package:hogi_milk_admin/models/option.dart';
import 'package:hogi_milk_admin/providers/option_manager.dart';
import 'package:hogi_milk_admin/widgets/custom_button.dart';
import 'package:hogi_milk_admin/widgets/input_field.dart';
import 'package:provider/provider.dart';

class ChangeOptions extends StatefulWidget {
  const ChangeOptions({super.key});

  @override
  State<ChangeOptions> createState() => _ChangeOptionsState();
}

class _ChangeOptionsState extends State<ChangeOptions> {

  late Future optionFuture;
  Future<void> obtainOptionFuture(){
    final provider = Provider.of<OptionManager>(context,listen: false);
    return provider.fetchOptions();
  }

  @override
  void initState() {
    // TODO: implement initState
    optionFuture = obtainOptionFuture();
    super.initState();
  }
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OptionManager>(context,listen: false);

    assert(provider.countControllers.length == provider.countControllers.length);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Change Options'),
          centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                provider.addNewController();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: optionFuture,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else{
            return Consumer<OptionManager>(
              builder: (context,data,child){
                return data.priceControllers.isEmpty ? const Center(
                  child: Text('No Options Yet!'),
                ): Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.countControllers.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 65,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: 60,
                                      child: Text('Opt ${index + 1}'),
                                    ),
                                    Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: InputField(
                                                label: 'Item',
                                                type: TextInputType.number,
                                                controller: data.countControllers[index],
                                              ),
                                            ),
                                            Expanded(
                                                child: InputField(
                                                  label: 'Price',
                                                  type: TextInputType.number,
                                                  controller: data.priceControllers[index],
                                                  suffixText: 'Ks',
                                                ))
                                          ],
                                        )),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 60,
                                      child: IconButton(
                                          onPressed: ()=> provider.deleteController(index),
                                          icon: Icon(Icons.delete,color: warningColor)
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        CustomButton(
                            label: 'Save Changes',
                            onPressed: (){
                              if(formKey.currentState!.validate()){

                                provider.saveOptions().then((value){
                                  showMessage(context, 'Changes Saved');
                                });
                              }
                            }
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
