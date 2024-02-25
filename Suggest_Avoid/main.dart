import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Suggested Avoid'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "            Tuenphai",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "       Suggestion to Avoid",
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
          ProductBox(
            name: "Flood",
            image: "flooded-house.png",
          ),
          ProductBox(
            name: "WildeFire",
            image: "wildfire.png",
          ),
          ProductBox(
            name: "Landslide",
            image: "landslide.png",
          ),
          ProductBox(
            name: "Earthquake",
            image: "earthquake.png",
          ),
          ProductBox(
            name: "Temperature extreme",
            image: "global-warming.png",
          ),
        ],
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
        height: 120, 
        padding: const EdgeInsets.all(2),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), 
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10), 
                child: Image.asset(
                  "assets/" + image,
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
                          fontSize: 30, 
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
          Center(
            child: Text(
              'Fire',
              style: TextStyle(fontSize: 40),
            ),
          ), 
          Padding(
            padding: const EdgeInsets.only(left: 20.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SizedBox(height: 20), 
              Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/home.jpg', 
                    width: 100, 
                    height: 100, 
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
