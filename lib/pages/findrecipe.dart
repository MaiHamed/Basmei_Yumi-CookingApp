import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FindRecipePage(),
    );
  }
}

class FindRecipePage extends StatelessWidget {
  final List<Map<String, dynamic>> recipes = [
    {
      "name": "Spicy Chicken Curry",
      "description": "A flavorful chicken curry with a spicy kick.",
      "time": "40 minutes",
      "serves": "4 people",
      "ingredients": ["Chicken", "Tomatoes", "Chili", "Coconut Milk", "Onions"],
      "instructions": [
        "Cut chicken into medium pieces.",
        "Sauté onions and chili in oil.",
        "Add chicken and cook for 10 minutes.",
        "Pour in coconut milk and simmer for 20 minutes.",
        "Serve hot with rice."
      ]
    },
    {
      "name": "Vegetable Soup",
      "description": "A hearty soup with fresh seasonal vegetables.",
      "time": "30 minutes",
      "serves": "6 people",
      "ingredients": ["Carrots", "Celery", "Potatoes", "Broth", "Spinach"],
      "instructions": [
        "Chop all vegetables.",
        "Boil broth and add vegetables.",
        "Simmer for 25 minutes.",
        "Add spinach and cook for 5 minutes.",
        "Serve warm."
      ]
    },
    {
      "name": "Pork Stir Fry",
      "description": "Quick and savory pork stir fry with veggies.",
      "time": "25 minutes",
      "serves": "3 people",
      "ingredients": ["Pork", "Bell Peppers", "Soy Sauce", "Garlic", "Green Beans"],
      "instructions": [
        "Slice pork into thin strips.",
        "Heat oil and cook pork until browned.",
        "Add garlic and vegetables.",
        "Stir in soy sauce and cook for 10 minutes.",
        "Serve with noodles."
      ]
    },
    {
      "name": "Lentil Stew",
      "description": "A nutritious stew with lentils and spices.",
      "time": "35 minutes",
      "serves": "5 people",
      "ingredients": ["Lentils", "Tomatoes", "Cumin", "Onions", "Carrots"],
      "instructions": [
        "Rinse lentils thoroughly.",
        "Sauté onions and cumin in oil.",
        "Add lentils and chopped carrots.",
        "Pour in water and simmer for 25 minutes.",
        "Serve with bread."
      ]
    },
    {
      "name": "Fish Tacos",
      "description": "Crispy fish tacos with a tangy sauce.",
      "time": "20 minutes",
      "serves": "4 people",
      "ingredients": ["Fish Fillets", "Tortillas", "Cabbage", "Lime", "Salsa"],
      "instructions": [
        "Cook fish fillets until crispy.",
        "Warm tortillas.",
        "Add cabbage and fish to tortillas.",
        "Drizzle with lime and salsa.",
        "Serve immediately."
      ]
    },
    {
      "name": "Eggplant Parmesan",
      "description": "Baked eggplant with cheese and tomato sauce.",
      "time": "45 minutes",
      "serves": "4 people",
      "ingredients": ["Eggplant", "Tomato Sauce", "Mozzarella", "Parmesan", "Basil"],
      "instructions": [
        "Slice and bake eggplant.",
        "Layer with tomato sauce and cheeses.",
        "Bake for 30 minutes.",
        "Garnish with basil.",
        "Serve hot."
      ]
    },
    {
      "name": "Quinoa Salad",
      "description": "A light salad with quinoa and fresh veggies.",
      "time": "20 minutes",
      "serves": "6 people",
      "ingredients": ["Quinoa", "Cucumber", "Tomatoes", "Parsley", "Lemon"],
      "instructions": [
        "Cook quinoa according to package.",
        "Chop cucumber and tomatoes.",
        "Mix with quinoa and parsley.",
        "Drizzle with lemon juice.",
        "Serve cold."
      ]
    },
    {
      "name": "Lamb Kebabs",
      "description": "Grilled lamb skewers with aromatic spices.",
      "time": "30 minutes",
      "serves": "4 people",
      "ingredients": ["Lamb", "Yogurt", "Cumin", "Onions", "Bell Peppers"],
      "instructions": [
        "Marinate lamb in yogurt and cumin.",
        "Skewer with onions and peppers.",
        "Grill for 15 minutes.",
        "Turn occasionally.",
        "Serve with rice."
      ]
    },
    {
      "name": "Creamy Spinach Pasta",
      "description": "Pasta with a creamy spinach sauce.",
      "time": "25 minutes",
      "serves": "4 people",
      "ingredients": ["Pasta", "Spinach", "Cream", "Garlic", "Parmesan"],
      "instructions": [
        "Cook pasta according to package.",
        "Sauté garlic and spinach in cream.",
        "Mix with drained pasta.",
        "Sprinkle with parmesan.",
        "Serve hot."
      ]
    },
    {
      "name": "Turkey Chili",
      "description": "A spicy chili made with ground turkey.",
      "time": "40 minutes",
      "serves": "6 people",
      "ingredients": ["Turkey", "Kidney Beans", "Chili Powder", "Tomatoes", "Onions"],
      "instructions": [
        "Cook turkey until browned.",
        "Add onions and chili powder.",
        "Stir in tomatoes and beans.",
        "Simmer for 30 minutes.",
        "Serve with cornbread."
      ]
    },
    {
      "name": "Zucchini Fritters",
      "description": "Crispy fritters made from fresh zucchini.",
      "time": "20 minutes",
      "serves": "4 people",
      "ingredients": ["Zucchini", "Eggs", "Flour", "Garlic", "Dill"],
      "instructions": [
        "Grate zucchini and drain excess water.",
        "Mix with eggs, flour, and garlic.",
        "Fry spoonfuls until golden.",
        "Sprinkle with dill.",
        "Serve with yogurt."
      ]
    },
    {
      "name": "Shrimp Stir Fry",
      "description": "Quick stir fry with shrimp and veggies.",
      "time": "15 minutes",
      "serves": "3 people",
      "ingredients": ["Shrimp", "Broccoli", "Soy Sauce", "Ginger", "Sesame Oil"],
      "instructions": [
        "Heat sesame oil and add ginger.",
        "Cook shrimp until pink.",
        "Add broccoli and soy sauce.",
        "Stir fry for 5 minutes.",
        "Serve with rice."
      ]
    },
    {
      "name": "Sweet Potato Mash",
      "description": "Creamy mashed sweet potatoes with spices.",
      "time": "30 minutes",
      "serves": "5 people",
      "ingredients": ["Sweet Potatoes", "Butter", "Cinnamon", "Milk", "Nutmeg"],
      "instructions": [
        "Boil sweet potatoes until soft.",
        "Mash with butter and milk.",
        "Add cinnamon and nutmeg.",
        "Mix well.",
        "Serve warm."
      ]
    },
    {
      "name": "Beef Stew",
      "description": "A rich stew with tender beef and veggies.",
      "time": "50 minutes",
      "serves": "6 people",
      "ingredients": ["Beef", "Carrots", "Potatoes", "Thyme", "Broth"],
      "instructions": [
        "Brown beef in a pot.",
        "Add chopped carrots and potatoes.",
        "Pour in broth and add thyme.",
        "Simmer for 40 minutes.",
        "Serve hot."
      ]
    },
    {
      "name": "Coconut Rice",
      "description": "Fragrant rice cooked with coconut milk.",
      "time": "25 minutes",
      "serves": "4 people",
      "ingredients": ["Rice", "Coconut Milk", "Salt", "Lime Leaves", "Sugar"],
      "instructions": [
        "Rinse rice thoroughly.",
        "Cook with coconut milk and salt.",
        "Add lime leaves and sugar.",
        "Simmer until tender.",
        "Serve with curry."
      ]
    },
  ];

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Recipe" , style: TextStyle( color: Colors.white),),
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
      ),
      extendBodyBehindAppBar: true, // allows background to show behind AppBar
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/smart.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content with transparent background
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 8), // offset for AppBar
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Card(
                color: Colors.white.withOpacity(0.85), // slight transparency to see background
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(recipe["name"],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(recipe["description"]),
                      const SizedBox(height: 8),
                      Text("${recipe["time"]} | ${recipe["serves"]}"),
                      const SizedBox(height: 8),
                      Text("Ingredients: ${recipe["ingredients"].join(", ")}"),
                      const SizedBox(height: 8),
                      const Text("Instructions:"),
                      ...recipe["instructions"]
                          .map<Widget>((step) => Text("- $step"))
                          .toList(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}