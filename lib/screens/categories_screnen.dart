import 'package:flutter/material.dart';
import 'package:meal/data/dummy_data%20(1).dart';
import 'package:meal/model/meal.dart';

import 'package:meal/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.avialableMeals});

  final List<Meal> avialableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0,
      upperBound: 1,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 3 / 2),
        children: [
          for (final category in availableCategories)
            CategoryGridIem(
                availableMeals: widget.avialableMeals, category: category),
        ],
      ),
      builder: (context, child) => Padding(
        padding: EdgeInsets.only(top: 140 - _controller.value * 140),
        child: child,
      ),
    );
  }
}
