import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'emergencyCall.dart';
import 'MapsPage.dart';

class DetailedInformationPage extends StatefulWidget {
  final String eventId;

  DetailedInformationPage({Key? key, required this.eventId}) : super(key: key);

  @override
  _DetailedInformationPageState createState() =>
      _DetailedInformationPageState();
}

class _DetailedInformationPageState extends State<DetailedInformationPage> {
  bool _isLoading = true;
  String _title = '';
  String _description = '';
  String _date = '';
  String _imageLink =
      'https://th.bing.com/th/id/R.0c0b85f24b1d0392a387b7cb89f0e99f?rik=df%2bNhtV%2fiwz88A&pid=ImgRaw&r=0'; // Placeholder image link
  String _category = '';
  String _location = '';
  String _sources = '';
  @override
  void initState() {
    super.initState();
    _fetchEventDetails();
  }

  Future<void> _fetchEventDetails() async {
    // Check if it's the fake news event
    if (widget.eventId == 'FAKE_NEWS_001') {
      // Manually set the state for the fake event
      setState(() {
        _isLoading = false;
        _title = 'Floods in Bangwa, Thailand';
        _category = 'Floods';
        _date = '2024-03-31T00:00:00Z';
        _location = '13.7903, 100.2201'; // Example coordinates for Bangwa
        _sources = 'No source avaliable';
        _description = 'Severe floods reported in Bangwa region, Thailand.';
        _imageLink =
            'https://th.bing.com/th/id/R.06d4c22175264f47b729a7919fa529ee?rik=pbKIvGkUdCDRQw&pid=ImgRaw&r=0'; // Example image link for the fake news
      });
    } else {
      final url =
          'https://eonet.gsfc.nasa.gov/api/v2.1/events/${widget.eventId}';
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          // Parse the response and assign values to state variables
          setState(() {
            _isLoading = false;
            _title = jsonResponse['title'];
            _category = jsonResponse['categories'][0]['title'];
            _date = jsonResponse['geometries'][0]['date'];
            _location = jsonResponse['geometries'][0]['coordinates'].join(", ");
            _sources = (jsonResponse['sources'] as List)
                .map((source) => source['url'])
                .join("\n");
            _description =
                jsonResponse['description'] ?? 'No description available';
            // Add logic here if you want to dynamically set the image link based on the response
          });
        } else {
          print(
              'Failed to load event details. Status code: ${response.statusCode}');
          setState(() {
            _isLoading = false;
          });
        }
      } catch (error) {
        print('Error fetching event details: $error');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Detailed Information',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[900],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // To avoid overflow issues when content is too long
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_imageLink
                        .isNotEmpty) // Only show the image if the link is set
                      Image.network(
                        _imageLink,
                        height: 200.0,
                        width: double
                            .infinity, // to stretch to the container's width
                        fit: BoxFit.cover,
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        // Use a Column to display all details in order
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Category: $_category',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Date: $_date',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Location: $_location',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Sources: $_sources',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Description: $_description',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapsPage(
                  eventId: widget.eventId), // Replace with your actual MapsPage
            ),
          );
        },
        label: Text('Map'),
        icon: Icon(Icons.map),
        backgroundColor: Colors.green[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
