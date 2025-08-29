import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> shoppingList = ['orange juice'];
  final List<String> gotList = ['sugar', 'apple'];
  List<String> searchResults = [];

  // API quota info
  int pointsUsed = 0;
  int pointsTotalUsed = 0;
  int pointsLeft = 0;

  // Replace with your Spoonacular API key
  final String apiKey = '9f43b727bfcd43b9b430cd0c992968c9';

  // Text for menu
  String clearMenuText = 'Clear All';

  // Search function using Autocomplete endpoint
  Future<void> searchFood(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    final url = Uri.parse(
      'https://api.spoonacular.com/food/ingredients/autocomplete?query=$query&number=10&apiKey=$apiKey',
    );

    try {
      final response = await http.get(url);

      // Read quota headers
      pointsUsed =
          int.tryParse(response.headers['x-api-quota-request'] ?? '0') ?? 0;
      pointsTotalUsed =
          int.tryParse(response.headers['x-api-quota-used'] ?? '0') ?? 0;
      pointsLeft =
          int.tryParse(response.headers['x-api-quota-left'] ?? '0') ?? 0;

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        setState(() {
          searchResults = data.map((item) => item['name'] as String).toList();
        });
      } else if (response.statusCode == 402 || response.statusCode == 429) {
        print("⚠️ API limit reached!");
        setState(() => searchResults = []);
      } else {
        print('Error fetching data: ${response.statusCode}');
        setState(() => searchResults = []);
      }
    } catch (e) {
      print('Exception: $e');
      setState(() => searchResults = []);
    }
  }

  void addItemToList(String item) {
    if (!shoppingList.contains(item) && !gotList.contains(item)) {
      setState(() {
        shoppingList.add(item);
        searchResults = [];
        _searchController.clear();
        clearMenuText = 'Clear All'; // Reset menu text when adding new item
      });
    }
  }

  void toggleItem(String item, bool isGot) {
    setState(() {
      if (isGot) {
        shoppingList.remove(item);
        gotList.add(item);
      } else {
        gotList.remove(item);
        shoppingList.add(item);
      }
    });
  }

  void deleteItem(String item, bool isGot) {
    setState(() {
      if (isGot) {
        shoppingList.remove(item);
      } else {
        gotList.remove(item);
      }
    });
  }

  void clearAllItems() {
    setState(() {
      shoppingList.clear();
      gotList.clear();
      clearMenuText = 'Clear Completed';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[700],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shopping List',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              'You have ${shoppingList.length} items in the list',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.signal_cellular_alt, color: Colors.white),
            onSelected: (value) {
              if (value == 'clear') {
                clearAllItems();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'clear', child: Text(clearMenuText)),
            ],
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height, // <-- Full screen height
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset('assets/shop.jpg', fit: BoxFit.cover),
            ),
            // Foreground content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Field
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for food',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                      onChanged: searchFood,
                    ),
                    SizedBox(height: 10),
                    // Search Results in Outlined Boxes
                    if (searchResults.isNotEmpty)
                      Container(
                        height: 200,
                        child: ListView.builder(
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.pink, width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.white.withOpacity(0.7),
                                ),
                                onPressed: () =>
                                    addItemToList(searchResults[index]),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      searchResults[index],
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    SizedBox(height: 20),
                    Text(
                      'What\'s in my list',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    ...shoppingList.map(
                      (item) => ListTile(
                        leading: Checkbox(
                          value: false,
                          onChanged: (_) => toggleItem(item, true),
                          activeColor: Colors.pink,
                        ),
                        title: Text(item, style: TextStyle(color: Colors.white)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.grey),
                          onPressed: () => deleteItem(item, true),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'What I got',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    ...gotList.map(
                      (item) => ListTile(
                        leading: Checkbox(
                          value: true,
                          onChanged: (_) => toggleItem(item, false),
                          activeColor: Colors.pink,
                        ),
                        title: Text(item, style: TextStyle(color: Colors.white)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.grey),
                          onPressed: () => deleteItem(item, false),
                        ),
                      ),
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