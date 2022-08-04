import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapThree extends StatefulWidget {
  @override
  State<GoogleMapThree> createState() => _GoogleMapThreeState();
}
class _GoogleMapThreeState extends State<GoogleMapThree> {
  GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  static const LatLng showLocation = const LatLng(21.2469,72.8515);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: GoogleMap( //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition( //innital position in map
          target: showLocation, //initial position
          zoom: 15.0, //initial zoom level
        ),
        markers: markers, //markers to show on map
        mapType: MapType.normal, //map type
        onMapCreated: (controller) async { //method called when map is created
          setState(() {
            mapController = controller;
          });
          String imgurl = "https://www.fluttercampus.com/img/car.png";
          Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl))
              .load(imgurl))
              .buffer
              .asUint8List();
          setState(() {
            markers.add(Marker( //add first marker
              markerId: MarkerId(showLocation.toString()),
              position: showLocation, //position of marker
              infoWindow: InfoWindow( //popup info
                title: 'Marker Title First ',
                snippet: 'My Custom Subtitle',
              ),
              icon: BitmapDescriptor.defaultMarker, //Icon for Marker
            ));
            markers.add(Marker( //add third marker
              markerId: MarkerId(showLocation.toString()),
              position: LatLng(23.0225, 72.5714), //position of marker
              infoWindow: InfoWindow( //popup info
                title: 'Marker Title Third ',
                snippet: 'My Custom Subtitle',
              ),
              icon: BitmapDescriptor.defaultMarker,
            ));

            markers.add(Marker(
              markerId: MarkerId(showLocation.toString()),
              position: LatLng(21.1702,72.8311),
              icon: BitmapDescriptor.fromBytes(bytes),
            ),
            );
          });
        },
      ),
    );
  }
}