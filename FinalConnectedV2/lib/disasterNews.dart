import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';
import 'detailedInformation.dart';
import 'emergencycall.dart';

class EonetEvent {
  final String id, title, description, link, category, date;

  EonetEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.link,
    required this.category,
    required this.date,
  });

  factory EonetEvent.fromJson(Map<String, dynamic> json) => EonetEvent(
        id: json['id'],
        title: json['title'],
        description: json['description'] ?? 'No description available',
        link: json['link'],
        category: json['categories'].isNotEmpty
            ? json['categories'][0]['title']
            : 'Unknown',
        date: json['geometries'].isNotEmpty
            ? json['geometries'][0]['date']
            : 'Unknown Date',
      );
}

class Category {
  final int id;
  final String title;

  Category({required this.id, required this.title});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
    );
  }
}

class DisasterNewsPage extends StatefulWidget {
  @override
  _DisasterNewsPageState createState() => _DisasterNewsPageState();
}

class _DisasterNewsPageState extends State<DisasterNewsPage> {
  final Color _primaryColor = Color.fromARGB(255, 9, 109, 6);
  List<Category> _categories = [];
  int? _selectedCategoryId;
  bool _isLoading = true;
  List<EonetEvent> _events = [];
  bool _isSortAsc = true;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchEvents();
  }

  Future<void> _fetchCategories() async {
    const url = 'https://eonet.gsfc.nasa.gov/api/v2.1/categories';
    try {
      final response = await http.get(Uri.parse(url));
      final jsonResponse = json.decode(response.body);
      final categoriesJson = jsonResponse['categories'] as List;
      final loadedCategories = categoriesJson
          .map((categoryJson) => Category.fromJson(categoryJson))
          .toList();
      final allCategory = Category(id: 0, title: 'All');
      setState(() {
        _categories = [allCategory] + loadedCategories;
        _selectedCategoryId = 0;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> _fetchEvents({int? categoryId}) async {
    setState(() {
      _isLoading = true;
    });

    String url = 'https://eonet.gsfc.nasa.gov/api/v2.1/events';
    print('Fetching events from: $url');

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final eventsJson = jsonResponse['events'] as List;
        List<EonetEvent> loadedEvents = eventsJson
            .map((eventJson) => EonetEvent.fromJson(eventJson))
            .toList();

        loadedEvents.add(EonetEvent(
          id: 'FAKE_NEWS_001',
          title: 'Floods in Bangwa, Thailand',
          description: 'Severe floods reported in Bangwa region, Thailand.',
          link:
              'https://example.com/floods-in-bangwa', 
          category: 'Floods',
          date: '2024-03-31T00:00:00Z', 
        ));

        if (categoryId != null && categoryId != 0) {
          loadedEvents = loadedEvents.where((event) {
            final eventCategory = _categories
                .firstWhere((cat) => cat.id == categoryId,
                    orElse: () => Category(id: -1, title: 'Unknown'))
                .title;
            return event.category == eventCategory;
          }).toList();
        }

        print('Loaded ${loadedEvents.length} events');

        setState(() {
          _events = loadedEvents;
          _isLoading = false;
        });
      } else {
        print('Failed to load events. Status code: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching events: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _sortEvents() {
    setState(() {
      _events.sort((a, b) =>
          _isSortAsc ? a.date.compareTo(b.date) : b.date.compareTo(a.date));
    });
  }

  Widget _buildDropdownButton({
    required String hint,
    int? selectedValue,
    required List<Category> items,
    required ValueChanged<int?> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _primaryColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedValue,
          icon: Icon(Icons.arrow_drop_down, color: _primaryColor),
          style: TextStyle(color: _primaryColor, fontSize: 16),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<int>>((Category category) {
            return DropdownMenuItem<int>(
              value: category.id,
              child: Text(category.title),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSortButton() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 8.0), 
      decoration: BoxDecoration(
        border: Border.all(
            color: _primaryColor), 
        borderRadius:
            BorderRadius.circular(5.0), 
      ),
      child: Row(
        mainAxisSize: MainAxisSize
            .min, 
        children: [
          IconButton(
            icon: Icon(_isSortAsc ? Icons.arrow_upward : Icons.arrow_downward),
            color: _primaryColor,
            onPressed: () {
              setState(() {
                _isSortAsc = !_isSortAsc;
              });
              _sortEvents();
            },
          ),
          Text(
            _isSortAsc ? 'Ascending' : 'Descending',
            style: TextStyle(
              color: _primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSortButton(),
        Expanded(
          child: _buildDropdownButton(
            hint: 'Category',
            selectedValue: _selectedCategoryId,
            items: _categories,
            onChanged: (int? newCategoryId) {
              setState(() {
                _selectedCategoryId = newCategoryId;
              });
              _fetchEvents(categoryId: _selectedCategoryId);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventList() {
    if (_events.isEmpty) {
      return Expanded(
        child: Center(
          child: Text('No events found for the selected category.'),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        key: PageStorageKey('event-list-${_selectedCategoryId}'),
        itemCount: _events.length,
        itemBuilder: (_, index) {
          final event = _events[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text(
              'Category: ${event.category}\nDate: ${event.date.split('T')[0]}',
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      DetailedInformationPage(eventId: event.id),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Disaster News', style: TextStyle(color: Colors.white)),
        backgroundColor: _primaryColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildFiltersRow(),
                _buildEventList(),
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
