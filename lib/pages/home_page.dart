import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'smartfounder.dart';
import 'findrecipe.dart';
import 'nutrition.dart';
import 'share.dart';
import 'challange.dart';
import 'Shop.dart';
import 'acc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.64;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.deepOrange,
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.deepOrange,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/homeimg.jpg",
              fit: BoxFit.fitHeight,
              alignment: Alignment.topCenter,
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "Choose ",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "your ",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "option ",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    buildButton("Smart Recipe Founder", buttonWidth, context),
                    const SizedBox(height: 10),
                    buildButton("Find Recipes", buttonWidth, context),
                    const SizedBox(height: 10),
                    buildButton(
                      "Nutrition and Healthy Mode",
                      buttonWidth,
                      context,
                    ),
                    const SizedBox(height: 10),
                    buildButton("Share Your Recipe", buttonWidth, context),
                    const SizedBox(height: 10),
                    buildButton("Daily Challenge", buttonWidth, context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.deepOrange,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Accpage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.deepOrange,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShopPage()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.chat_bubble,
                  color: Colors.deepOrange,
                  size: 28,
                ),
                onPressed: () {
                  _showSocialMediaOptions(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String text, double width, BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (text == "Smart Recipe Founder") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SmartFounderPage()),
            );
          } else if (text == "Find Recipes") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FindRecipePage()),
            );
          } else if (text == "Nutrition and Healthy Mode") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NutritionPage()),
            );
          } else if (text == "Share Your Recipe") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SharePage()),
            );
          } else if (text == "Daily Challenge") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChallengePage()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _showSocialMediaOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Connect with us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.facebook, // you can use a Facebook icon if you have one
                  color: Colors.blue, // Facebook color
                  size: 30,
                ),
                title: const Text('Facebook'),
                onTap: () async {
                  final Uri url = Uri.parse('https://www.facebook.com/');
                  try {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    print('Could not launch $url: $e');
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons
                      .camera_alt, // you can change this to a relevant icon if you want
                  color: Colors.purple, // Instagram color
                  size: 30,
                ),
                title: const Text('Instagram'),
                onTap: () async {
                  final Uri url = Uri.parse('https://www.instagram.com/');
                  try {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    print('Could not launch $url: $e');
                  }
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(
                  Icons.g_mobiledata,
                  color: Colors.red,
                  size: 30,
                ),
                title: const Text('Google'),
                onTap: () async {
                  final Uri url = Uri.parse('https://www.google.com/');
                  try {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    print('Could not launch $url: $e');
                  }
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
