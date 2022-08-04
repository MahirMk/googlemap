import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapOne extends StatefulWidget {
  @override
  State<GoogleMapOne> createState() => _GoogleMapOneState();
}

class _GoogleMapOneState extends State<GoogleMapOne> {

  GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  static const LatLng showLocation = const LatLng(27.7089427, 85.3086209);

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiple Markers in Google Map"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: GoogleMap( //Map widget from google_maps_flutter package
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(21.1702,72.8311),
          zoom: 15.0, //initial zoom level
        ),
        markers: getmarkers(),
        mapType: MapType.normal,
        //map type
        onMapCreated: (controller) { //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(//add first marker
        markerId: MarkerId(showLocation.toString()),
        position: showLocation,
        infoWindow: InfoWindow( //popup info
          title: 'Marker Title First ',
          snippet: 'My Custom Subtitle',

        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(
          Marker(
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(21.1702,72.8311), //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Surat',
          snippet: 'Gujarat',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(
          Marker(
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(21.2030,72.8087), //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Adajan ',
          snippet: 'Rander Road',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
      markers.add(Marker(//add third marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(21.1431,72.8431), //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Udhna ',
          snippet: 'Surat',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    });
    return markers;
  }
}
