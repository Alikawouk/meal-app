import 'package:flutter/material.dart';

import 'package:meal/model/meal.dart';
import 'package:meal/screens/meals_screen.dart';
import '../model/category.dart';

class CategoryGridIem extends StatelessWidget {
  const CategoryGridIem(
      {super.key, required this.category, required this.availableMeals});
  final Category category;

  final List<Meal> availableMeals;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        final filteredMeal = availableMeals
            .where((element) => element.categories.contains(category.id))
            .toList();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return MealsScreen(
                title: category.title,
                meals: filteredMeal,
              );
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(colors: [
            category.color.withOpacity(0.54),
            category.color.withOpacity(0.9),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
