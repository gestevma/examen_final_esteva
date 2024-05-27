import 'dart:async';

import 'package:examen_final_esteva/provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();
  MapType currentMapType = MapType.normal;
  Set<Marker> markers = new Set<Marker>();
  Set<Polyline> _polyline = {};
  String? distance;

  LatLng getLatLng(String valor) {
    final latLng = valor.substring(4).split(',');
    final latitude = double.parse(latLng[0]);
    final longitude = double.parse(latLng[1]);

    return LatLng(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition _puntInicial = CameraPosition(
      target: this.getLatLng(FireBaseProvider.selectedPlat.geo),
      zoom: 17,
      tilt: 50,
    );

    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
        ),
        body: Stack(
          children: [
            GestureDetector(
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: this.currentMapType,
                markers: markers,
                initialCameraPosition: _puntInicial,
                polylines: _polyline,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            Container(
              child: Column(
                children: [
                  ElevatedButton(
                    child: Row(
                      children: [
                        Text("Centrar"),
                        Icon(Icons.center_focus_weak)
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                    onPressed: () async {
                      final GoogleMapController controller =
                          await _controller.future;
                      await controller.animateCamera(
                          CameraUpdate.newCameraPosition(_puntInicial));
                    },
                  ),
                  ElevatedButton(
                    child: Row(
                      children: [
                        Text("Canviar mode"),
                        Icon(Icons.type_specimen)
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                    onPressed: () {
                      setState(() {
                        if (this.currentMapType == MapType.normal) {
                          this.currentMapType = MapType.hybrid;
                        } else {
                          this.currentMapType = MapType.normal;
                        }
                      });
                    },
                  ),
                  Container(
                    width: 10,
                    height: 50,
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              margin: EdgeInsets.only(left: 20.0, right: 0.0),
            ),
            Positioned(
                top: 20,
                left: 250,
                child: Container(
                  child: Text(
                    distance != null ? "${distance}Km" : "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ));
  }
}
