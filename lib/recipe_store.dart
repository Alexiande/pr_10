import 'package:mobx/mobx.dart';
import 'package:pr_10/recipe.dart';

part 'recipe_store.g.dart';

class RecipeStore = _RecipeStore with _$RecipeStore;

abstract class _RecipeStore with Store {
  @observable
  List<Recipe> recipes = [];

  @observable
  bool isLoading = false;

  @action
  void setLoading(bool value){
    isLoading = value;
  }

  @action
  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
  }

  @action
  void removeRecipe(Recipe recipe) {
    recipes.remove(recipe);
  }
}