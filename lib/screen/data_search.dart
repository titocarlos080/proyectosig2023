
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final List<String> listaEjemplo = [
    'Flutter',
    'Dart',
    'Widget',
    'Desarrollo móvil',
    'OpenAI',
    // ... tus otros elementos de búsqueda
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
@override
  String? get searchFieldLabel => 'Buscar productos..';

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
         icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context,query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implementa la lógica para mostrar los resultados de la búsqueda
    return Center(
      child: Text('Resultados para: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implementa la lógica para mostrar sugerencias mientras escribes
    final suggestionList = query.isEmpty
        ? listaEjemplo
        : listaEjemplo
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length, 
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            // Define lo que sucede al seleccionar un resultado de búsqueda
            showResults(context);
          },
        );
      },
    );
  }
}