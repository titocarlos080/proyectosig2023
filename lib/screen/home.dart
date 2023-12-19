import 'dart:convert';

import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:proyectosig2023/screen/data_search.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int pagIndex = 0;
  LatLng initialPosition = const LatLng(-17.78645190737223, -63.15488047444324);
  LatLng myActualPosition = const LatLng(-17.784302, -63.180892);
  late Position currentPosition;
  String casetas = '';
  MapController mapController = MapController();
  String csetas = '';
  GeoJsonParser geoJsonParser = GeoJsonParser(
    defaultPolygonIsFilled: true,
    defaultMarkerColor: Colors.red,
    defaultPolygonBorderColor: Colors.red,
    defaultPolygonFillColor: Colors.red.withOpacity(0.1),
    defaultCircleMarkerColor: Colors.red.withOpacity(0.25),
  );

  static const String token =
      "pk.eyJ1IjoidGl0b2NhcmxvcyIsImEiOiJjbHA4dXgzcXMwMnlpMmltd21mNnRxdmhwIn0.r2WGVUNs51u2bTO8smvgWQ";

  final double minZoom = 5;
  final double maxZoom = 25;
  final double initialZoom = 13;
  final double initialZoomPosition = 15;
  List<Polygon> polygonsList = [];

  bool loadingData = false;

  bool myFilterFunction(Map<String, dynamic> properties) {
    if (properties['section'].toString().contains('Point M-4')) {
      return false;
    } else {
      return true;
    }
  }

  // this is callback that gets executed when user taps the marker
  void onTapMarkerFunction(Map<String, dynamic> map) {
    // ignore: avoid_print
    print('onTapMarkerFunction: $map');
  }

  Future<void> processData() async {
    geoJsonParser.parseGeoJsonAsString(csetas);

    // ignore: avoid_print
    print(geoJsonParser);
  }

  @override
  void initState() {
    _initializeData();
    geoJsonParser.setDefaultMarkerTapCallback(onTapMarkerFunction);
    geoJsonParser.filterFunction = myFilterFunction;
    loadingData = false;
    super.initState();
  }

  Future<void> _initializeData() async {
    casetas = (await rootBundle.loadString('assets/dataGeo/casetas.json'));
    Map<String, dynamic> geoJson = json.decode(casetas);

    // Obtener la lista de características (features)
    List<dynamic> features = geoJson['features'];
    // Iterar sobre las geometrías
    for (var feature in features) {
      Map<String, dynamic> geometry = feature['geometry'];
      String type = geometry['type'];
      if (type == 'Polygon') {
        List<dynamic> coordinates = geometry['coordinates'][0];

        // Crear una lista de LatLng para el polígono
        List<LatLng> polygonCoordinates = coordinates.map((coord) {
          double lat = coord[1];
          double lng = coord[0];
          // ignore: prefer_interpolation_to_compose_strings, avoid_print
          print(lat.toString() + 'as' + lng.toString());
          return LatLng(lat, lng);
        }).toList();
        Polygon polygon = Polygon(
            
          points: polygonCoordinates,
          isFilled: true,
          
          borderColor: Colors.black,
          borderStrokeWidth: 1,
          
        );
        polygonsList.add(polygon);
        // ignore: avoid_print
        print(polygonCoordinates);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            ),
          ],
        ),
        body: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            minZoom: minZoom,
            maxZoom: maxZoom,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
              additionalOptions: const {
                'accessToken': token,
                'id': 'mapbox/streets-v11',
              },
            ),
            loadingData
                ? const Center(child: CircularProgressIndicator())
                : PolygonLayer(
                    polygons: geoJsonParser.polygons,
                    drawLabelsLast: true,
                    polygonLabels: true
                    
                    ),
            PolygonLayer(polygons: polygonsList),
            
            MarkerLayer(
              markers: [
                Marker(
                    point: initialPosition,
                    height: 1,width: 1,
                    
                    child: const Icon(Icons.location_pin, color: Colors.blue,)),

                Marker(point: myActualPosition, child: const Icon(Icons.location_on,color:Colors.red,))    
              ],
            ),
          ],
        ),
        bottomNavigationBar:
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ElevatedButton(
            child: const Icon(Icons.shop),
            onPressed: () {},
          ),
          ElevatedButton(
            child: const Icon(Icons.shopping_cart_rounded),
            onPressed: () {},
          ),
          ElevatedButton(
            child: const Icon(Icons.my_location_sharp),
            onPressed: () {
              getCurrentLocation();
            },
          ),
          ElevatedButton(
            child: const Icon(Icons.route_rounded),
            onPressed: () {},
          ),
          ElevatedButton(
            child: const Icon(Icons.place_outlined),
            onPressed: () {
              mapController.move(initialPosition, 18);
            },
          ),
        ]));
  }

  Future<Position> determinePosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    currentPosition = await determinePosition();
    setState(() {
      myActualPosition =
          LatLng(currentPosition.latitude, currentPosition.longitude);
      mapController.move(myActualPosition, initialZoomPosition);
        
      // ignore: avoid_print
      print(myActualPosition);
    });
  }
}
