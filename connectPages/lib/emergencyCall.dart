import 'package:flutter/material.dart';
import 'main.dart';

class EmergencyCallPage extends StatelessWidget {
  final List<Map<String, String>> emergencyNumbers = [
    {'agency': 'Medical Emergency', 'number': '1669'},
    {'agency': 'Police', 'number': '191'},
    {'agency': 'Fire Department', 'number': '199'},
    {'agency': 'Meteorological Department', 'number': '1182'},
    {
      'agency': 'Department of Disaster Prevention and Mitigation',
      'number': '1784'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This will remove go back arrow
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Text(
            'TuanPhai',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: emergencyNumbers.length,
              itemBuilder: (context, index) {
                final emergency = emergencyNumbers[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(emergency['agency'] ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      subtitle: Row(
                        children: [
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              print(
                                  '${emergency['agency']}: ${emergency['number']}');
                            },
                            child: Text(emergency['number'] ?? '',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side:
                                      BorderSide(color: Colors.green.shade900),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(), // Add a divider after each list item
                  ],
                );
              },
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
