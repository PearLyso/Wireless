import 'package:flutter/material.dart';
import 'emergencyCall.dart';
import 'disasterNews.dart';
import 'locationMap.dart';
import 'suggestAvoid.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, this.title = ""}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This will remove go back arrow
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        children: <Widget>[
          Text(
            "TueanPhai",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          CircleAvatar(
            radius: 80,
            child: Image.network(
              "https://cdn-icons-png.flaticon.com/128/3135/3135715.png",
              width: 160,
              height: 160,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          ),
          Text(
            "Users",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // News Button
            height: 50,
            width: MediaQuery.of(context).size.width * 0.1,
            child: TextButton(
              onPressed: () {
                print("News");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisasterNewsPage()),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                backgroundColor: Color.fromARGB(255, 9, 109, 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/512/2965/2965879.png',
                    width: 40,
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 30.0, 0, 30.0),
                  ),
                  Text(
                    "News",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // Set User Location Button
            height: 50,
            width: MediaQuery.of(context).size.width * 0.1,
            child: TextButton(
              onPressed: () {
                print("Set User Location");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationMapPage()),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                backgroundColor: Color.fromARGB(255, 9, 109, 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/512/7474/7474511.png',
                    width: 40,
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 30.0, 0, 30.0),
                  ),
                  Text(
                    "Set User Location",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // Suggest Avoid Button
            height: 50,
            width: MediaQuery.of(context).size.width * 0.1,
            child: TextButton(
              onPressed: () {
                print("Suggest Avoid");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SuggestAvoidPage(title: 'Suggest Avoid')),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                backgroundColor: Color.fromARGB(255, 9, 109, 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://cdn-icons-png.flaticon.com/512/10782/10782398.png',
                    width: 40,
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 30.0, 0, 30.0),
                  ),
                  Text(
                    "Suggest Avoid",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
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
