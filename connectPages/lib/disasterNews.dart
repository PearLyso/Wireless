import 'package:flutter/material.dart';
import 'package:maps/main.dart';
import 'detailedInformation.dart';
import 'emergencyCall.dart';

class DisasterNewsPage extends StatefulWidget {
  @override
  _DisasterNewsPageState createState() => _DisasterNewsPageState();
}

class _DisasterNewsPageState extends State<DisasterNewsPage> {
  final Color primaryColor = Color(0xFF105C2F);
  final List<String> categories = [
    'All',
    'Drought',
    'Earthquake',
    'Floods',
    'Landslides',
    'Temperature Extremes',
    'Wildfire'
  ];
  String selectedCategory = 'All';
  String sortOrder = 'Ascending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('News', style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _buildDropdownButton(
                      'Sort Order',
                      sortOrder,
                      ['Ascending', 'Descending'],
                      (String? value) {
                        if (value != null) {
                          setState(() {
                            sortOrder = value;
                          });
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: _buildDropdownButton(
                      'Category',
                      selectedCategory,
                      categories,
                      (String? value) {
                        if (value != null) {
                          setState(() {
                            selectedCategory = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.grey),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedInformationPage(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Image.network(
                          'https://th.bing.com/th/id/OIP.7kxFZ4M9NrlYsOPmctMwtwHaE7?rs=1&pid=ImgDetMain',
                          width: 50,
                          height: 50),
                      title: Text('Disaster Name'),
                      subtitle: Text('Date: \nCategories: \nLocate: '),
                      trailing: Icon(Icons.map, color: primaryColor),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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

  Widget _buildDropdownButton(String hint, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: Icon(Icons.arrow_drop_down, color: primaryColor),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: primaryColor),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(color: primaryColor)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
