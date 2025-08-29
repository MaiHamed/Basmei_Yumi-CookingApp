import 'package:flutter/material.dart';

class SmartFounderPage extends StatefulWidget {
  const SmartFounderPage({super.key});

  @override
  _SmartFounderPageState createState() => _SmartFounderPageState();
}

class _SmartFounderPageState extends State<SmartFounderPage> {
  List<String> selectedIngredients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // عشان الصورة تبقى ورا الـ AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "SmartFounder",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/smart.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            100,
            20,
            20,
          ), // عشان النص ما يبقاش ورا الـ AppBar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select your available ingredients and get suitable recipes",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildIngredientBox("Tomatoes", Colors.white),
                    _buildIngredientBox("Onions", Colors.white),
                    _buildIngredientBox("Garlic", Colors.white),
                    _buildIngredientBox("Chicken", Colors.white),
                    _buildIngredientBox("Rice", Colors.white),
                    _buildIngredientBox("Olive Oil", Colors.white),
                    _buildIngredientBox("Carrots", Colors.white),
                    _buildIngredientBox("Potatoes", Colors.white),
                    _buildIngredientBox("Green Pepper", Colors.white),
                    _buildIngredientBox("Eggs", Colors.white),
                    _buildIngredientBox("Cheese", Colors.white),
                    _buildIngredientBox("Beef", Colors.white),
                    _buildIngredientBox("Pasta", Colors.white),
                    _buildIngredientBox("Mushrooms", Colors.white),
                    _buildIngredientBox("Bell Peppers", Colors.white),
                    _buildIngredientBox("Spinach", Colors.white),
                    _buildIngredientBox("Lemon", Colors.white),
                    _buildIngredientBox("Herbs", Colors.white),
                    _buildIngredientBox("Hot dog", Colors.white),
                    _buildIngredientBox("Fish", Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Selected Ingredients:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[200],
                ),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 8,
                runSpacing: 5,
                children: selectedIngredients.map((ingredient) {
                  return Chip(
                    label: Text(ingredient),
                    backgroundColor: Colors.orangeAccent,
                    onDeleted: () {
                      setState(() {
                        selectedIngredients.remove(ingredient);
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecommendedRecipePage(
                          ingredients: selectedIngredients,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    "Find Your Recipe",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientBox(String ingredient, Color color) {
    bool isSelected = selectedIngredients.contains(ingredient);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (!isSelected) {
            selectedIngredients.add(ingredient);
          } else {
            selectedIngredients.remove(ingredient);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange : color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26),
        ),
        child: Center(
          child: Text(
            ingredient,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : (color == Colors.white ? Colors.black : Colors.white),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class RecommendedRecipePage extends StatelessWidget {
  final List<String> ingredients;
  const RecommendedRecipePage({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final recipes = [
      {
        "title": "Garlic Butter Chicken",
        "description": "Juicy chicken cooked with garlic and herbs in butter",
        "time": "35 minutes",
        "servings": "4 people",
        "ingredients": ["Chicken", "Garlic", "Olive Oil", "Herbs"],
        "instructions": [
          "Season chicken with herbs",
          "Sauté garlic in olive oil",
          "Cook chicken until golden and cooked through",
          "Serve hot",
        ],
      },
      {
        "title": "Cheesy Potato Bake",
        "description": "Baked potatoes with creamy cheese topping",
        "time": "40 minutes",
        "servings": "3 people",
        "ingredients": ["Potatoes", "Cheese", "Olive Oil", "Herbs"],
        "instructions": [
          "Slice potatoes thinly",
          "Layer with cheese in a baking dish",
          "Bake until golden",
          "Sprinkle herbs and serve",
        ],
      },
      {
        "title": "Beef and Bell Pepper Stir Fry",
        "description": "Quick beef stir fry with colorful bell peppers",
        "time": "25 minutes",
        "servings": "3 people",
        "ingredients": ["Beef", "Bell Peppers", "Garlic", "Olive Oil"],
        "instructions": [
          "Cut beef into thin strips",
          "Stir fry beef in olive oil",
          "Add garlic and bell peppers",
          "Cook until vegetables are tender",
          "Serve hot with rice",
        ],
      },
      {
        "title": "Spinach and Cheese Omelette",
        "description": "Healthy omelette with spinach and melted cheese",
        "time": "15 minutes",
        "servings": "1-2 people",
        "ingredients": ["Eggs", "Spinach", "Cheese", "Olive Oil"],
        "instructions": [
          "Beat eggs",
          "Sauté spinach lightly",
          "Pour eggs over spinach",
          "Add cheese and cook until set",
          "Serve warm",
        ],
      },
      {
        "title": "Lemon Garlic Fish",
        "description": "Tender fish fillets cooked with lemon and garlic",
        "time": "20 minutes",
        "servings": "2 people",
        "ingredients": ["Fish", "Lemon", "Garlic", "Olive Oil"],
        "instructions": [
          "Marinate fish with lemon and garlic",
          "Sauté in olive oil until cooked",
          "Garnish with herbs and serve",
        ],
      },
      {
        "title": "Tomato Pasta",
        "description": "Simple and delicious tomato pasta",
        "time": "25 minutes",
        "servings": "2-3 people",
        "ingredients": ["Pasta", "Tomatoes", "Garlic", "Olive Oil"],
        "instructions": [
          "Cook pasta",
          "Sauté garlic and tomatoes",
          "Mix pasta with sauce",
          "Serve hot with herbs",
        ],
      },
      {
        "title": "Chicken Fried Rice",
        "description": "Quick fried rice with chicken and vegetables",
        "time": "30 minutes",
        "servings": "3 people",
        "ingredients": [
          "Rice",
          "Chicken",
          "Carrots",
          "Green Pepper",
          "Olive Oil",
        ],
        "instructions": [
          "Cook rice",
          "Sauté chicken and vegetables",
          "Mix rice with chicken and veggies",
          "Season and serve hot",
        ],
      },
      {
        "title": "Mushroom and Spinach Pasta",
        "description": "Creamy pasta with mushrooms and spinach",
        "time": "25 minutes",
        "servings": "2 people",
        "ingredients": ["Pasta", "Mushrooms", "Spinach", "Garlic", "Olive Oil"],
        "instructions": [
          "Cook pasta",
          "Sauté mushrooms, garlic, and spinach",
          "Mix with pasta and serve",
        ],
      },
      {
        "title": "Beef and Potato Stew",
        "description": "Hearty beef stew with potatoes and carrots",
        "time": "50 minutes",
        "servings": "4 people",
        "ingredients": ["Beef", "Potatoes", "Carrots", "Onions", "Olive Oil"],
        "instructions": [
          "Brown beef in olive oil",
          "Add onions, carrots, and potatoes",
          "Simmer until tender",
          "Season and serve hot",
        ],
      },
      {
        "title": "Hot Dog Sandwich",
        "description": "Quick hot dog sandwich with cheese and herbs",
        "time": "10 minutes",
        "servings": "1-2 people",
        "ingredients": ["Hot dog", "Cheese", "Herbs"],
        "instructions": [
          "Cook hot dog",
          "Place in bread with cheese",
          "Add herbs and serve",
        ],
      },
      {
        "title": "Vegetable Stir Fry",
        "description": "Mixed vegetables stir fry with olive oil",
        "time": "20 minutes",
        "servings": "2-3 people",
        "ingredients": ["Carrots", "Green Pepper", "Onions", "Olive Oil"],
        "instructions": [
          "Sauté vegetables in olive oil",
          "Season with herbs",
          "Serve hot as side or main dish",
        ],
      },
      {
        "title": "Cheese Omelette",
        "description": "Fluffy omelette with melted cheese",
        "time": "10 minutes",
        "servings": "1 person",
        "ingredients": ["Eggs", "Cheese", "Olive Oil"],
        "instructions": [
          "Beat eggs",
          "Cook in olive oil",
          "Add cheese and fold omelette",
          "Serve hot",
        ],
      },
      {
        "title": "Lemon Herb Chicken",
        "description": "Juicy chicken flavored with lemon and herbs",
        "time": "35 minutes",
        "servings": "4 people",
        "ingredients": ["Chicken", "Lemon", "Herbs", "Olive Oil"],
        "instructions": [
          "Marinate chicken with lemon and herbs",
          "Cook in olive oil until golden",
          "Serve with sides",
        ],
      },
      {
        "title": "Garlic Mashed Potatoes",
        "description": "Creamy mashed potatoes with garlic flavor",
        "time": "30 minutes",
        "servings": "3-4 people",
        "ingredients": ["Potatoes", "Garlic", "Olive Oil", "Herbs"],
        "instructions": [
          "Boil potatoes",
          "Mash with sautéed garlic and olive oil",
          "Add herbs and serve",
        ],
      },
      {
        "title": "Spinach and Cheese Quiche",
        "description": "Baked quiche with spinach and cheese",
        "time": "45 minutes",
        "servings": "4 people",
        "ingredients": ["Spinach", "Cheese", "Eggs", "Olive Oil"],
        "instructions": [
          "Mix spinach, cheese, and eggs",
          "Pour into baking dish",
          "Bake until set",
          "Serve warm",
        ],
      },
      {
        "title": "Fish with Vegetables",
        "description": "Lightly cooked fish with fresh vegetables",
        "time": "25 minutes",
        "servings": "2 people",
        "ingredients": [
          "Fish",
          "Carrots",
          "Green Pepper",
          "Olive Oil",
          "Lemon",
        ],
        "instructions": [
          "Sauté vegetables in olive oil",
          "Cook fish with lemon",
          "Serve fish on top of vegetables",
        ],
      },
    ];
    final filteredRecipes = recipes.where((recipe) {
      final recipeIngredients = List<String>.from(
        recipe["ingredients"] as List,
      );
      return ingredients.every(
        (selected) => recipeIngredients.contains(selected),
      );
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true, // <-- allow body to go behind AppBar
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
        title: const Text(
          "Recommended Recipes",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Recommeded.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content with padding
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              kToolbarHeight +
                  MediaQuery.of(context).padding.top +
                  20, // <-- top padding
              20,
              20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "You selected:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 5,
                  children: ingredients.map((ingredient) {
                    return Chip(
                      label: Text(ingredient),
                      backgroundColor: Colors.orangeAccent,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: filteredRecipes.isEmpty
                      ? Center(
                          child: Text(
                            "No recipes match your selected ingredients.",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = filteredRecipes[index];
                            return _buildRecipeCard(
                              title: recipe["title"] as String,
                              description: recipe["description"] as String,
                              time: recipe["time"] as String,
                              servings: recipe["servings"] as String,
                              ingredients: List<String>.from(
                                recipe["ingredients"] as List,
                              ),
                              instructions: List<String>.from(
                                recipe["instructions"] as List,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard({
    required String title,
    required String description,
    required String time,
    required String servings,
    required List<String> ingredients,
    required List<String> instructions,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text("⏰ $time  👥 $servings", style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 10),
            Text(
              "Ingredients:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              children: ingredients
                  .map(
                    (ing) => Chip(
                      label: Text(ing),
                      backgroundColor: Colors.green[100],
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            Text(
              "Instructions:",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            ...instructions.map(
              (step) => Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("⦿ ", style: TextStyle(fontSize: 16)),
                    Expanded(child: Text(step)),
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
