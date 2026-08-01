import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/map_controller.dart';

class MapView extends GetView<MapPageController> {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Found items map')),
      body: Obx(
        () => GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(33.5731, -7.5898), // default: Casablanca
            zoom: 12,
          ),
          markers: controller.markers.value,
        ),
      ),
    );
  }
}
