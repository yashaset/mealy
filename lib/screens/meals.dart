import 'package:flutter/material.dart';
import 'package:mealy/models/meal.dart';
import 'package:mealy/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({required this.meals, required this.title, super.key});

  final List<Meal> meals;
  final String title;

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return MealItem(meal: meals[index]);
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
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: content);
  }
}
