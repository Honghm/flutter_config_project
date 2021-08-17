import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:template_flutter/views/map/real_time_map.dart';

class MapScreen extends StatelessWidget {
  static final id = '/map';
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RealTimeMap(
            mapType: MapType.normal,
            onMapCreated: (controller) {},
            onLocationChanged: (location) {}),
      ),
    );
  }
}
