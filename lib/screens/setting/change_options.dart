import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/widgets/input_field.dart';

class ChangeOptions extends StatefulWidget {
  const ChangeOptions({super.key});

  @override
  State<ChangeOptions> createState() => _ChangeOptionsState();
}

class _ChangeOptionsState extends State<ChangeOptions> {
  List<TextEditingController> itemControllers = [];
  List<TextEditingController> priceControllers = [];

  @override
  void initState() {
    // TODO: implement initState
    itemControllers = List.generate(6, (index) => TextEditingController());
    priceControllers = List.generate(6, (index) => TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assert(itemControllers.length == priceControllers.length);
    return Scaffold(
      appBar: AppBar(title: const Text('Change Options'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 48),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: itemControllers.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 60,
                            child: Text('Opt ${index + 1}'),
                          ),
                          Expanded(
                              child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: 100,
                                child: InputField(
                                  label: 'Item',
                                  controller: itemControllers[index],
                                ),
                              ),
                              Expanded(
                                  child: InputField(
                                label: 'Price',
                                controller: priceControllers[index],
                                suffixText: 'Ks',
                              ))
                            ],
                          ))
                        ],
                      ),
                    );
                  }),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    onPressed: () {},
                    child: const Text('Save Changes')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
