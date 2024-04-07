import 'package:flutter/material.dart';
import 'package:mealy/data/dummy_data.dart';
import 'package:mealy/models/category.dart';
import 'package:mealy/models/meal.dart';
import 'package:mealy/screens/meals.dart';
import 'package:mealy/widgets/GridItem.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {required this.availableMeals,
      required this.onToggleFavorite,
      super.key});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;
  void _selectCategory(BuildContext context, Category category) {
    final meals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return MealsScreen(
        meals: meals,
        title: category.title,
        onToggleFavorite: (meal) => onToggleFavorite(meal),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in availableCategories)
          GridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}
