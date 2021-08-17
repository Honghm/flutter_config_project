import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:template_flutter/common/utils/tools.dart';

class RealTimeMap extends StatefulWidget {
  final MapType mapType;
  final void Function(GoogleMapController controller) onMapCreated;
  final double zoom;
  final Duration listenInterval;
  final void Function(Position newLocation) onLocationChanged;
  const RealTimeMap(
      {Key? key,
      required this.mapType,
      required this.onMapCreated,
      this.zoom = 24,
      this.listenInterval = const Duration(seconds: 1),
      required this.onLocationChanged})
      : super(key: key);
  @override
  _RealTimeMapState createState() => _RealTimeMapState();
}

class _RealTimeMapState extends State<RealTimeMap> {
  late final GoogleMapController mapController;
  late Position currentLocation;
  late Future<Position> firstLocation;
  StreamSubscription? locationSubscription;

  @override
  void initState() {
    super.initState();
    firstLocation = Utils.getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
    if (locationSubscription != null) locationSubscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final location = snapshot.data;
            return GoogleMap(
              myLocationEnabled: true,
              onMapCreated: (controller) {
                mapController = controller;
                widget.onMapCreated(controller);
                startTracking();
              },
              mapType: widget.mapType,
              initialCameraPosition:
                  _buildCameraPosition(location!.latitude, location.longitude),
            );
          } else
            return CircularProgressIndicator();
        }
        return Container();
      },
      future: firstLocation,
    );
  }

  CameraPosition _buildCameraPosition(double latitude, double longitude) {
    return CameraPosition(
      target: LatLng(
        latitude,
        longitude,
      ),
      zoom: widget.zoom,
    );
  }

  void startTracking() async {
    if (locationSubscription != null) locationSubscription!.cancel();
    locationSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      intervalDuration: widget.listenInterval,
    ).listen(
      (newLocationData) {
        if (mapController != null) {
          widget.onLocationChanged(newLocationData);
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(
                  newLocationData.latitude,
                  newLocationData.longitude,
                ),
                zoom: widget.zoom,
              ),
            ),
          );
        }
      },
    );
  }
}
