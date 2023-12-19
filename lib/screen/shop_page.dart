import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class ShopPageScreen extends StatefulWidget {
  const ShopPageScreen({super.key});

  @override
  State<ShopPageScreen> createState() => _ShopPageScreenState();
}

class _ShopPageScreenState extends State<ShopPageScreen> {
  LatLng initialPosition = const LatLng(-17.78645190737223, -63.15488047444324);
  LatLng myActualPosition = const LatLng(-17.784302, -63.180892);
  late Position currentPosition;
  MapController mapController = MapController();

  static const String token =
      "pk.eyJ1IjoidGl0b2NhcmxvcyIsImEiOiJjbHA4dXgzcXMwMnlpMmltd21mNnRxdmhwIn0.r2WGVUNs51u2bTO8smvgWQ";

  final double minZoom = 5;
  final double maxZoom = 25;
  final double initialZoom = 13;
  final double initialZoomPosition = 15;

  get moveToLocation => null;

  get getCurrentLocation => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'id': 'mapbox/streets-v12',
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                  point: initialPosition, child: const Icon(Icons.location_pin))
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(onPressed: zoomIn, child: const Icon(Icons.zoom_in)),
          ElevatedButton(onPressed: zoomOut, child: const Icon(Icons.zoom_out)),
          ElevatedButton(
              onPressed: moveToLocation, child: const Icon(Icons.place)),
          ElevatedButton(
              onPressed: getCurrentLocation,
              child: const Icon(Icons.location_searching_sharp)),
          ElevatedButton(
              onPressed: drawRoute, child: const Icon(Icons.directions)),
        ],
      ),
    );
  }

  void zoomIn() {}

  void zoomOut() {}

  void drawRoute() {}
}
