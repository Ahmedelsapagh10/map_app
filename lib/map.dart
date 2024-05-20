import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: _markers.toSet(),
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  final LatLng _center = const LatLng(37.7749, -122.4194);

  final List<Marker> _markers = const [
    Marker(
      markerId: MarkerId('marker_1'),
      position: LatLng(37.7749, -122.4194),
      infoWindow: InfoWindow(title: 'San Francisco'),
    ),
    Marker(
      markerId: MarkerId('marker_2'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(34.0522, -118.2437),
      infoWindow: InfoWindow(title: 'Los Angeles'),
    ),
    Marker(
      markerId: MarkerId('marker_3'),
      position: LatLng(40.7128, -74.0060),
      infoWindow: InfoWindow(title: 'New York City'),
    ),
    Marker(
      markerId: MarkerId('marker_4'),
      position: LatLng(41.8781, -87.6298),
      infoWindow: InfoWindow(title: 'Chicago'),
    ),
    Marker(
      markerId: MarkerId('marker_5'),
      position: LatLng(29.7604, -95.3698),
      infoWindow: InfoWindow(title: 'Houston'),
    ),
    Marker(
      markerId: MarkerId('marker_6'),
      position: LatLng(33.4484, -112.0740),
      infoWindow: InfoWindow(title: 'Phoenix'),
    ),
    Marker(
      markerId: MarkerId('marker_7'),
      position: LatLng(39.7392, -104.9903),
      infoWindow: InfoWindow(title: 'Denver'),
    ),
    Marker(
      markerId: MarkerId('marker_8'),
      position: LatLng(47.6062, -122.3321),
      infoWindow: InfoWindow(title: 'Seattle'),
    ),
  ];
  GoogleMapController? mapController;
}
