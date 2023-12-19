import 'dart:convert';

class Casetas {
  final int fid;
  final int id;
  final String latitud;
  final String longitud;
  final String nombre;
  final String sigla;
  final List<List<List<double>>> coordinates;

  Casetas({
    required this.fid,
    required this.id,
    required this.latitud,
    required this.longitud,
    required this.nombre,
    required this.sigla,
    required this.coordinates,
  });

  List<Casetas> parseGeoJson(String geoJsonString) {
  final Map<String, dynamic> geoJson = json.decode(geoJsonString);
  final List<dynamic> features = geoJson['features'];

  return features.map((feature) {
    final properties = feature['properties'];
    final geometry = feature['geometry'];

    return Casetas(
      fid: properties['FID'],
      id: properties['Id'],
      latitud: properties['Latitud'],
      longitud: properties['Longitud'],
      nombre: properties['Nombre'],
      sigla: properties['Sigla'],
      coordinates: List<List<List<double>>>.from(geometry['coordinates'][0].map<List<double>>((coord) {
        return List<double>.from(coord);
      })),
    );
  }).toList();
}
}
