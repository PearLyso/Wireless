import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'home.dart';
import 'emergencyCall.dart';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapsPage extends StatefulWidget {
  final String eventId;

  MapsPage({Key? key, required this.eventId}) : super(key: key);

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController mapController;
  late LatLng disasterLocation;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  LatLng? userLocation;
  double? distanceInMeters;

  @override
  void initState() {
    super.initState();
    _getDisasterLocation();
    _getUserLocation();
  }

  Future<void> _getDisasterLocation() async {
    if (widget.eventId == 'FAKE_NEWS_001') {
      double latitude = 13.721206196538787;
      double longitude = 100.45768665200146;

      setState(() {
        disasterLocation = LatLng(latitude, longitude);
        _markers.add(
          Marker(
            markerId: MarkerId("disaster"),
            position: disasterLocation,
            infoWindow: InfoWindow(title: "Floods in Bangwa, Thailand"),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      });
    } else {
      final url =
          'https://eonet.gsfc.nasa.gov/api/v2.1/events/${widget.eventId}';
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);

          final coordinates = jsonResponse['geometries'][0]['coordinates'];
          double latitude = coordinates[1];
          double longitude = coordinates[0];

          print(
              'Disaster Location -> Latitude: $latitude, Longitude: $longitude');

          setState(() {
            disasterLocation = LatLng(latitude, longitude);
            _markers.add(
              Marker(
                markerId: MarkerId("disaster"),
                position: disasterLocation,
                infoWindow: InfoWindow(title: "Disaster Location"),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed),
              ),
            );
            // Fit the map to show both pins
            if (userLocation != null) {
              _setMapFitToTour(_markers);
            }
          });
        } else {
          print(
              'Failed to load event details. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error fetching event details: $error');
      }
    }
  }

  void _setMapFitToTour(Set<Marker> markers) {
    var bounds = _boundsFromLatLngList(
        markers.map((marker) => marker.position).toList());
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.longitude;
        y0 = y1 = latLng.latitude;
      } else {
        if (latLng.longitude > x1!) x1 = latLng.longitude;
        if (latLng.longitude < x0) x0 = latLng.longitude;
        if (latLng.latitude > y1!) y1 = latLng.latitude;
        if (latLng.latitude < y0!) y0 = latLng.latitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(y1!, x1!), southwest: LatLng(y0!, x0!));
  }

  Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng userLocation = LatLng(position.latitude, position.longitude);

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("user"),
          position: userLocation,
          infoWindow: InfoWindow(title: "Your Location"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
      if (disasterLocation != null) {
        distanceInMeters = Geolocator.distanceBetween(
          userLocation!.latitude,
          userLocation!.longitude,
          disasterLocation.latitude,
          disasterLocation.longitude,
        );

        _polylines.add(
          Polyline(
            polylineId: PolylineId('line1'),
            visible: true,
            points: [userLocation!, disasterLocation],
            width: 2,
            color: Colors.blue,
          ),
        );

        _setMapFitToTour(_markers);
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Map Location',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green[900],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: disasterLocation ?? LatLng(0.0, 0.0),
              zoom: 6.0,
            ),
            markers: _markers,
            polylines: _polylines,
          ),
          if (distanceInMeters != null)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: Text(
                  '${(distanceInMeters! / 1000).toStringAsFixed(2)} km',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            Expanded(
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
