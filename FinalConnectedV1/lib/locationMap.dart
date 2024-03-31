import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'main.dart';
import 'emergencyCall.dart';

class LocationMapPage extends StatefulWidget {
  @override
  _LocationMapPageState createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {
  loc.Location location = loc.Location();
  bool _serviceEnabled = false;
  loc.PermissionStatus? _permissionGranted;
  LatLng _currentPosition = LatLng(0, 0);
  GoogleMapController? _controller;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _checkLocationPermissions();
  }

  void _checkLocationPermissions() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final locData = await location.getLocation();
    LatLng newLocation =
        LatLng(locData.latitude ?? 0.0, locData.longitude ?? 0.0);

    setState(() {
      // Remove old markers
      _markers.clear();
      // Update current position
      _currentPosition = newLocation;
      // Add new marker at the current location
      _markers.add(
        Marker(
          markerId: MarkerId("currentLocation"),
          position: _currentPosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
      // Move the map camera to the new location
      _controller?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _updateMarker(_currentPosition);
  }

  void _updateMarker(LatLng position) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('currentPos'),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition,
                    zoom: 14.0,
                  ),
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  markers: _markers,
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _getCurrentLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF105C2F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              child:
                  Text('Get Location', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
              // Home Button
              child: TextButton(
                onPressed: () {
                  print("Home");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/128/619/619153.png',
                      width: 40,
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 30.0, 0, 30.0),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              // Emergency Call Button
              child: TextButton(
                onPressed: () {
                  print("Emergency Call");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmergencyCallPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/2991/2991174.png',
                      width: 24,
                      height: 24,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 30.0, 0, 30.0),
                    ),
                    Text(
                      "Emergency Call",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
