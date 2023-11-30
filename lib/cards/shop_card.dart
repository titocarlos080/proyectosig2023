import 'package:flutter/material.dart';

class Shop extends StatelessWidget {
  final String name;

  const Shop({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(name),
    );
  }
}