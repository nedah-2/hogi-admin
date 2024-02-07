import 'package:flutter/material.dart';
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      alignment: Alignment.center,
      child: const Text('No Order Yet!'),
    );
  }
}
