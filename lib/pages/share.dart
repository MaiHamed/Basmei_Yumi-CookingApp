import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _recipeController = TextEditingController();
  bool _loading = false;
  String _saveMessage = '';
  bool _pickingImage = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Pick image from gallery
  Future<void> _pickImage() async {
    if (_pickingImage) return;
    _pickingImage = true;

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null && mounted) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error picking image: $e')));
      }
    } finally {
      _pickingImage = false;
    }
  }

  // Save recipe (image as base64 in Firestore)
  Future<void> _saveRecipe() async {
    if (_recipeController.text.isEmpty || _image == null) {
      if (mounted) {
        setState(() => _saveMessage = 'Please add image and description');
      }
      return;
    }

    if (mounted) {
      setState(() {
        _loading = true;
        _saveMessage = '';
      });
    }

    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('No user logged in');

      // Convert image to base64
      final bytes = await _image!.readAsBytes();
      String base64Image = base64Encode(bytes);

      // Save recipe in Firestore
      DocumentReference recipeRef =
          await _firestore.collection('recipes').add({
        'uid': user.uid,
        'description': _recipeController.text.trim(),
        'imageBase64': base64Image,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Add recipe ID to user's savedRecipes
      await _firestore.collection('users').doc(user.uid).set({
        'savedRecipes': FieldValue.arrayUnion([recipeRef.id])
      }, SetOptions(merge: true));

      if (mounted) {
        setState(() {
          _loading = false;
          _saveMessage = 'Saved Successfully';
          _recipeController.clear();
          _image = null;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _saveMessage = 'Error: $e';
        });
      }
    }
  }

  void _reset() {
    if (mounted) {
      setState(() {
        _image = null;
        _recipeController.clear();
        _saveMessage = '';
      });
    }
  }

  @override
  void dispose() {
    _recipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Recipe',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/share.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.5),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.fromLTRB(16, kToolbarHeight + 32, 16, 16),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _image == null
                              ? const Icon(Icons.image,
                                  size: 120, color: Colors.grey)
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    _image!,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _pickImage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrangeAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text('Select Image',
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: _recipeController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: 'Recipe Description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _saveRecipe,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.deepOrange,
                            ),
                            child: const Text('Save Recipe',
                                style: TextStyle(fontSize: 16)),
                          ),
                          const SizedBox(height: 20),
                          if (_loading)
                            const CircularProgressIndicator()
                          else if (_saveMessage.isNotEmpty)
                            Text(
                              _saveMessage,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
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
}