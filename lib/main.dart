import 'package:flutter/material.dart';
import 'package:proyectosig2023/screen/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),

         darkTheme: ThemeData.dark().copyWith(
        // Ajustes específicos del tema oscuro
        primaryColor: Colors.blueGrey, // Color primario del tema oscuro
        hintColor: Colors.tealAccent, // Color de acento del tema oscuro
        dialogBackgroundColor: Colors.black, // Color de fondo del tema oscuro
        scaffoldBackgroundColor: Colors.grey[900], // Color de fondo de Scaffold del tema oscuro
        textTheme: ThemeData.dark().textTheme.apply(
          // Ajustes de texto específicos del tema oscuro
          bodyColor: Colors.white, // Color del texto del cuerpo
          displayColor: Colors.white, // Color del texto de pantalla
        ),
      ),
      themeMode: ThemeMode.system, 
       home: const HomePage(),
    );
  }
}
