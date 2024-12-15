import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pr_10/recipe.dart';
import 'package:pr_10/recipe_store.dart';  // Убедитесь, что путь верный

final recipeStore = RecipeStore();

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecipeListScreen(),
    );
  }
}

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  void initState() {
    super.initState();
    _loadInitialRecipes();
  }
  void _loadInitialRecipes() {
    recipeStore.setLoading(true);
    recipeStore.addRecipe(Recipe(
      name: 'Chicken Curry',
      description: 'A delicious and flavorful chicken curry.',
      imageUrl: 'https://www.indianhealthyrecipes.com/wp-content/uploads/2021/05/chicken-curry-recipe-1.jpg',
    ));
    recipeStore.addRecipe(Recipe(
      name: 'Spaghetti Bolognese',
      description: 'Classic Italian pasta with meat sauce.',
      imageUrl: 'https://www.simplyrecipes.com/thmb/v4_zW4bN1KzYp1L5q3jN7q_o7b4=/750x0/filters:no_upscale():max_bytes(150000):strip_icc()/simply-recipes-spaghetti-bolognese-lead-5-5c4727d2406642398d500796649b6029.jpg',
    ));
    recipeStore.addRecipe(Recipe(
      name: 'Vegetable Stir-Fry',
      description: 'Healthy and quick vegetable stir-fry.',
      imageUrl: 'https://www.bbcgoodfood.com/sites/default/files/recipe-collections/collection-image/2013/05/veggie-stir-fry-main.jpg',
    ));
    recipeStore.addRecipe(Recipe(
      name: 'Pancakes',
      description: 'Fluffy and yummy pancakes.',
      imageUrl: 'https://www.seriouseats.com/thmb/bQJv7z2Wf9h8k22-0MvR-uJpQ7I=/750x0/filters:no_upscale():max_bytes(150000):strip_icc()/20230103-pancakes-vicky-wasik-07-e4e99b480f234a93a0bf3a48f3055620.jpg',
    ));
    recipeStore.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Recipes')),
      body: Column(
        children: [
          Observer(
            builder: (_) =>
            recipeStore.isLoading
                ? const Center(child: Text('Loading Recipes...'),)
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Number of Recipes: ${recipeStore.recipes.length}'),
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) => ListView.builder(
                itemCount: recipeStore.recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipeStore.recipes[index];
                  return ListTile(
                    title: Text(recipe.name),
                    subtitle: Text(recipe.description),
                    leading: Image.network(recipe.imageUrl, width: 50, height: 50),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => recipeStore.removeRecipe(recipe), // Удаление рецепта
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          recipeStore.addRecipe(Recipe(
              name: 'New Recipe',
              description: 'This is a new recipe.',
              imageUrl: 'https://example.com/newrecipe.jpg'
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}