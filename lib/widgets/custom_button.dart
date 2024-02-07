import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.label,required this.onPressed});
  final String label;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(10)))),
          onPressed: ()=> onPressed(),
          child: Text(label)),
    );
  }
}
