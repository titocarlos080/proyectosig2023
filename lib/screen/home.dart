import 'package:flutter/material.dart';
import 'package:proyectosig2023/screen/data_search.dart';
import 'package:proyectosig2023/screen/screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int pagIndex = 0;

  @override
  Widget build(BuildContext context) {
    late Widget body;

    switch (pagIndex) {
      case 0:
        body = const ShopPageScreen();
        break;
      case 1:
        body = const CartPageScreen();
        break;

      case 2:
        body = const Column();

        break;
      case 3:
        body = const Column();

        break;
      default:
        body = const MapHome();
        break;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context,delegate:DataSearch());
            },
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        backgroundColor: Colors.cyan,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.my_location_sharp), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.route_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.place_outlined), label: ''),
        ],
        currentIndex: pagIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            pagIndex = index;
          });
        },
      ),
    );
  }
}
