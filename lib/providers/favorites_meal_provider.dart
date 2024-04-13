import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealy/models/meal.dart';
// Provider() is great if you have some static data
// if your is data is super dynamic then you should use StateNotifierProvider class that works together with StateNotifer class;

// this is something more or less like redux in react;
// toggleMealsFavoriteStatus is like an action:
class FavoritesMealNotifier extends StateNotifier<List<Meal>> {
  FavoritesMealNotifier() : super([]); //initial state

  bool toggleMealsFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((m) => meal.id != m.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoritesMealNotifier, List<Meal>>(
        (ref) => FavoritesMealNotifier());
