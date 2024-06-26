import 'package:flutter/material.dart';
import 'package:mealy/models/meal.dart';
import 'package:mealy/screens/meals_details.dart';
import 'package:mealy/widgets/meal_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({required this.meals, this.title, super.key});

  final List<Meal> meals;
  final String? title;

  void _handleSelectMeal(BuildContext context, Meal meal) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return MealsDetailsScreen(
        meal: meal,
      );
    }));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return MealItem(
          meal: meals[index],
          onSelectMeal: (meal) {
            _handleSelectMeal(context, meal);
          },
        );
      },
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Ooops....No items found",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(
              height: 16,
            ),
            Text(
              "try something else..sorry!",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
