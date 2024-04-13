import 'package:flutter/material.dart';
import 'package:mealy/providers/favorites_meal_provider.dart';
import 'package:mealy/providers/filters_provider.dart';
import 'package:mealy/providers/meals_provider.dart';
import 'package:mealy/screens/categories.dart';
import 'package:mealy/screens/filters.dart';
import 'package:mealy/screens/meals.dart';
import 'package:mealy/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kinitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() => _TabsState();
}

class _TabsState extends ConsumerState<Tabs> {
  int _selectedPageIndex = 0;

  void _setScreen(String screen) async {
    Navigator.of(context).pop();
    if (screen == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const Filters(),
        ),
      );
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final filters = ref.watch(filtersProvider);
    final availableMeals = meals.where((meal) {
      if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favoritesMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoritesMeals,
      );
      activePageTitle = "Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites")
        ],
      ),
    );
  }
}
