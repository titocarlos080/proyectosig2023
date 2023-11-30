import 'package:flutter/material.dart';
import 'package:proyectosig2023/cards/calles.dart';
import 'package:proyectosig2023/cards/cards.dart';

class MapHome extends StatelessWidget {
  const MapHome({super.key});

  @override
  Widget build(BuildContext context) {
    return   Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Plano del Centro Comercial',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
           const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:   [
              Shop(name: 'Tienda 1'),
              Shop(name: 'Tienda 2'),
              Shop(name: 'Tienda 3'),
            ],
          ),

          const SizedBox(height: 20),
            CustomPaint(
                size: const Size(300, 300),
                painter: StreetPainter(),
              ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Shop(name: 'Tienda 4'),
              Shop(name: 'Tienda 5'),
              Shop(name: 'Tienda 6'),
            ],
          ),
        ],
      ),
    );
  }
}
