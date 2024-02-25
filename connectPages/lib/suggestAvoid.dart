import 'package:flutter/material.dart';
import 'main.dart';
import 'emergencyCall.dart';

class SuggestAvoidPage extends StatelessWidget {
  const SuggestAvoidPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Tueanphai",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "Suggestion to Avoid",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        children: const <Widget>[
          SizedBox(height: 30),
          ProductBox(
            name: "Flood",
            image: "https://cdn-icons-png.flaticon.com/512/3242/3242644.png",
          ),
          SizedBox(height: 30),
          ProductBox(
            name: "WildeFire",
            image: "https://cdn-icons-png.flaticon.com/512/3242/3242689.png",
          ),
          SizedBox(height: 30),
          ProductBox(
            name: "Landslide",
            image: "https://cdn-icons-png.flaticon.com/512/3242/3242628.png",
          ),
          SizedBox(height: 30),
          ProductBox(
            name: "Earthquake",
            image: "https://cdn-icons-png.flaticon.com/512/3242/3242693.png",
          ),
          SizedBox(height: 30),
          ProductBox(
            name: "Temperature extreme",
            image: "https://cdn-icons-png.flaticon.com/512/6041/6041465.png",
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                    Padding(padding: EdgeInsets.fromLTRB(10, 30.0, 0, 30.0)),
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
                    Padding(padding: EdgeInsets.fromLTRB(10, 30.0, 0, 30.0)),
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

class ProductBox extends StatelessWidget {
  const ProductBox({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    double fontSize = 30;

    if (name == "Temperature extreme") {
      fontSize = 24;
    }
    return GestureDetector(
      onTap: () {
        if (name == "WildeFire") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondPage()),
          );
        }
      },
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(2),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  image,
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        this.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: fontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suggest Avoid',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade900,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Center(
                child: Opacity(
                  opacity: 0.2, // Adjust the opacity level
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/3242/3242689.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment:
                    Alignment.topCenter, // Align the text to the top center
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 50.0), // Add padding from the top
                  child: Text(
                    'Fire',
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  '1. Leave Quickly in a Fire:',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  "     \u2022 If there's a fire, get out fast. Don't use the elevator in tall buildings.",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  '2. Use Stairs to Escape:',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  "     \u2022 Always use the stairs, not the elevator, to get out of the building during a fire.",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  '3. Avoid Smoke and Falling Objects:',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  "     \u2022 Watch out for smoke, and stay away from things that might fall and hurt you. If you can, cover your nose with a wet cloth.",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  '4. Cover Your Nose and Escape:',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  "     \u2022 Put something over your nose and get out of there as fast as you can.",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                    Padding(padding: EdgeInsets.fromLTRB(10, 30.0, 0, 30.0)),
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
                    Padding(padding: EdgeInsets.fromLTRB(10, 30.0, 0, 30.0)),
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
