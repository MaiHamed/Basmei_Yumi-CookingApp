import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signup_page.dart';

class Accpage extends StatefulWidget {
  const Accpage({super.key});

  @override
  State<Accpage> createState() => _AccpageState();
}

class _AccpageState extends State<Accpage> {
  User? user;
  String userName = '';
  String userEmail = '';
  DateTime? memberSince;

  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() {
    user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const SignupPage()),
          (route) => false,
        );
      });
      return;
    }
    userName = user!.displayName ?? '';
    userEmail = user!.email ?? '';
    _loadMemberSince();
  }

  Future<void> _loadMemberSince() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    if (doc.exists) {
      Timestamp timestamp = doc.data()?['createdAt'] ?? Timestamp.now();
      if (mounted) {
        setState(() {
          memberSince = timestamp.toDate();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[600],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white70,
              radius: 20,
              child: Icon(Icons.person, color: Colors.pink[700]),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          userName.isEmpty ? 'User' : userName,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          String? newName = await showDialog<String>(
                            context: context,
                            builder: (context) {
                              String tempName = '';
                              return AlertDialog(
                                title: Text('Edit Name'),
                                content: TextField(
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: 'Enter new name',
                                  ),
                                  onChanged: (value) {
                                    tempName = value;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, tempName),
                                    child: Text('Update'),
                                  ),
                                ],
                              );
                            },
                          );
                          if (newName != null && newName.trim().isNotEmpty) {
                            try {
                              await user!.updateDisplayName(newName.trim());
                              await user!.reload();
                              user = FirebaseAuth.instance.currentUser;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user!.uid)
                                  .set({'name': newName.trim()},
                                      SetOptions(merge: true));
                              setState(() {
                                userName = newName.trim();
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Name updated successfully'),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to update name: $e'),
                                ),
                              );
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    userEmail.isEmpty ? '' : userEmail,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/account.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Foreground content
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '156 Recipes',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            '2,834 Followers',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            '189 Following',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white,)
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Member Since: ${memberSince != null ? '${memberSince!.month}/${memberSince!.year}' : ''}',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Recently Saved Recipes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .snapshots(),
                    builder: (context, userSnapshot) {
                      if (!userSnapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      List<dynamic> savedRecipeIds = [];
                      final userData =
                          userSnapshot.data?.data() as Map<String, dynamic>?;
                      if (userData != null &&
                          userData.containsKey('savedRecipes')) {
                        savedRecipeIds = userData['savedRecipes'];
                      }
                      if (savedRecipeIds.isEmpty) {
                        return Center(
                          child: Text(
                            'No saved recipes yet',
                            style: TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        );
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: savedRecipeIds.length,
                        itemBuilder: (context, index) {
                          String recipeId = savedRecipeIds[index];
                          return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('recipes')
                                .doc(recipeId)
                                .get(),
                            builder: (context, recipeSnapshot) {
                              if (!recipeSnapshot.hasData) {
                                return Container(
                                  width: 150,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                );
                              }
                              var recipeData = recipeSnapshot.data!.data()
                                  as Map<String, dynamic>?;
                              if (recipeData == null) return const SizedBox.shrink();
                              String base64Image = recipeData['imageBase64'] ?? '';
                              Uint8List? imageBytes;
                              if (base64Image.isNotEmpty) {
                                imageBytes = base64Decode(base64Image);
                              }
                              return _buildRecipeCard(
                                recipeData['description'] ?? 'No Description',
                                imageBytes,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupPage()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Center(child: Text('Logout')),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.uid)
                            .delete();
                        await user!.delete();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const SignupPage()),
                          (route) => false,
                        );
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Error deleting account: ${e.message}. Please log in again and try.')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Center(child: Text('Delete Account')),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 30)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(String title, Uint8List? imageBytes) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                color: Colors.green[100],
              ),
              child: imageBytes != null
                  ? ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(4)),
                      child: Image.memory(
                        imageBytes,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )
                  : const Center(
                      child: Icon(Icons.fastfood, color: Colors.green, size: 50),
                    ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}