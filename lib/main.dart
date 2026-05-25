import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps App',
      home: MapPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  // Telyu Bandung
  LatLng telkom = LatLng(-6.9730, 107.6300);

  // Wisata Kawah Putih
  LatLng wisata = LatLng(-7.1666, 107.4025);

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();

    markers.add(
      Marker(
        markerId: MarkerId("telkom"),
        position: telkom,
        infoWindow: InfoWindow(title: "Telkom University Bandung"),
      ),
    );
  }

  void pindahLokasi() {
    mapController.animateCamera(CameraUpdate.newLatLngZoom(wisata, 14));

    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId("wisata"),
          position: wisata,
          infoWindow: InfoWindow(title: "Kawah Putih"),
        ),
      );
    });
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Maps Flutter")),
      body: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(target: telkom, zoom: 14),
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pindahLokasi,
        child: Icon(Icons.location_on),
      ),
    );
  }
}
