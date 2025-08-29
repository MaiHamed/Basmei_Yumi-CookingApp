import 'package:flutter/material.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Challenges"),
        backgroundColor: Colors.pink[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Card
            Card(
              color: Colors.orange[50],
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ready to spice up your culinary skills with today's cooking challenges?",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            children: const [
                              Text(
                                "Today's Progress",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "1 of 4 completed",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "25%",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: const [
                              Icon(Icons.local_dining, color: Colors.orange),
                              Text(
                                "Cooking Streak",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "3 days",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: const [
                              Icon(Icons.star, color: Colors.orange),
                              Text(
                                "Chef Badges",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "2 earned",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Today's Challenges Header
            const Text(
              "Today's Culinary Challenges",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Challenge Items
            _buildChallengeItem(
              icon: Icons.play_lesson,
              title: "Master the Perfect Scrambled Eggs",
              subtitle:
                  "Learn the French technique for creamy, restaurant-quality scrambled eggs",
              difficulty: "Technique",
              level: "Easy",
            ),
            _buildChallengeItem(
              icon: Icons.local_dining,
              title: "Cook with Seasonal Vegetables",
              subtitle:
                  "Create a dish using at least vegetables that are in season right now",
              difficulty: "Ingredient",
              level: "Medium",
            ),
            _buildChallengeItem(
              icon: Icons.timer,
              title: "15-Minute Mediterranean Meal",
              subtitle:
                  "Prepare a tasty Mediterranean-inspired meal in under 15 minutes",
              difficulty: "Time",
              level: "Medium",
            ),
            _buildChallengeItem(
              icon: Icons.science,
              title: "Experiment with a Spice Blend",
              subtitle:
                  "Experiment with a spice blend you've never used before",
              difficulty: "Ingredient",
              level: "Easy",
            ),

            const SizedBox(height: 20),
            const Text(
              "Chef Achievements",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Achievements Horizontal Scroll
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildAchievementCard(
                    icon: Icons.local_dining,
                    title: "First Dish",
                    subtitle: "Complete your first cooking challenge",
                    status: "Unlocked",
                  ),
                  const SizedBox(width: 10),
                  _buildAchievementCard(
                    icon: Icons.star,
                    title: "Technique Master",
                    subtitle: "Complete 10 technique-based challenges",
                    status: "Unlocked",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String difficulty,
    required String level,
  }) {
    MaterialColor levelColor;
    switch (level.toLowerCase()) {
      case "easy":
        levelColor = Colors.green;
        break;
      case "medium":
        levelColor = Colors.orange;
        break;
      case "hard":
        levelColor = Colors.red;
        break;
      default:
        levelColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Chip(label: Text(difficulty), backgroundColor: Colors.yellow[100]),
          const SizedBox(width: 10),
          Chip(label: Text(level), backgroundColor: levelColor[100]),
        ],
      ),
    );
  }

  Widget _buildAchievementCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String status,
  }) {
    return Card(
      color: Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.orange),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 5),
            Text(
              status,
              style: TextStyle(
                color: status.toLowerCase() == "unlocked" ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}