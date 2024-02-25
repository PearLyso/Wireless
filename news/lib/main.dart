import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DisasterNewsPage(),
    );
  }
}

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
                  return ListTile(
                    leading: Image.network(
                        'https://th.bing.com/th/id/OIP.7kxFZ4M9NrlYsOPmctMwtwHaE7?rs=1&pid=ImgDetMain',
                        width: 50,
                        height: 50),
                    title: Text('Disaster Name'),
                    subtitle: Text('Date: \nCategories: \nLocate: '),
                    trailing: InkWell(
                      onTap: () {
                        //future link
                      },
                      child: Icon(Icons.map, color: primaryColor),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            Text('Home'),
            IconButton(
              icon: Icon(Icons.call),
              onPressed: () {},
            ),
            Text('Emergency Call'),
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
