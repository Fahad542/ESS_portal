import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';


class geotag extends StatefulWidget {
  final double initialLatitude;
  final double initialLongitude;

  const geotag({
    Key? key,
    required this.initialLatitude,
    required this.initialLongitude,
  }) : super(key: key);

  @override
  State<geotag> createState() => _GeotagScreenState();
}

class _GeotagScreenState extends State<geotag> {
  late CameraPosition location;
  late Marker marker;

  @override
  void initState() {
    super.initState();
    location = CameraPosition(
      target: LatLng(widget.initialLatitude, widget.initialLongitude),
      zoom: 15.0, // You can adjust the zoom level as needed
    );
    marker = Marker(
      markerId: MarkerId('geotag_marker'),
      position: LatLng(widget.initialLatitude, widget.initialLongitude),
      infoWindow: InfoWindow(title: 'Your Location'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Geotag'),
      ),
      body: GoogleMap(
        initialCameraPosition: location,
        markers: {marker},
      ),
    );
  }
}
