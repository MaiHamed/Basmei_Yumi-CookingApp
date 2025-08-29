import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NutritionPage extends StatefulWidget {
  const NutritionPage({Key? key}) : super(key: key);

  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _foodController = TextEditingController();
  String _calories = 'Calories have not been calculated yet';
  bool _loading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _calculateCalories() async {
    if (_foodController.text.isEmpty) {
      setState(() {
        _calories = 'Please enter a food name';
      });
      return;
    }

    setState(() {
      _loading = true;
      _calories = '';
    });

    try {
      var response = await http.get(
        Uri.parse(
          'https://api.spoonacular.com/recipes/guessNutrition?title=${Uri.encodeComponent(_foodController.text)}&apiKey=9f43b727bfcd43b9b430cd0c992968c9',
        ),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['calories'] != null && result['calories']['value'] != null) {
          setState(() {
            _calories = 'Calories: ${result['calories']['value']} kcal';
          });
        } else {
          setState(() {
            _calories = 'Could not detect calories for this food';
          });
        }
      } else {
        setState(() {
          _calories = 'Error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _calories = 'Error calculating calories: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _reset() {
    setState(() {
      _image = null;
      _foodController.clear();
      _calories = 'Calories have not been calculated yet';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Calorie Calculator',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/N.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay and content
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                  16, kToolbarHeight + 32, 16, 16),
              child: Column(
                children: [
                  // Image selection card
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 8,
                    color: Colors.white.withOpacity(0.9),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _image == null
                              ? const Icon(
                                  Icons.image,
                                  size: 120,
                                  color: Colors.grey,
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    _image!,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _pickImage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrangeAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text(
                              'Select Image',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Food input and calories card
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 8,
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _foodController,
                            decoration: InputDecoration(
                              labelText: 'Enter Food Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _calculateCalories,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Colors.deepOrange,
                            ),
                            child: const Text(
                              'Calculate Calories',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (_loading)
                            const CircularProgressIndicator()
                          else
                            Text(
                              _calories,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                
                                     Colors.black
                                    
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reset,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        child: const Icon(Icons.refresh),
        tooltip: 'Reset',
      ),
    );
  }

  @override
  void dispose() {
    _foodController.dispose();
    super.dispose();
  }
}