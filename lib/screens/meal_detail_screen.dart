import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal/model/meal.dart';
import 'package:meal/providers/favorite_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favMeal = ref.watch(favoritesMealsProvider);
    final bool isFavorite = favMeal.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoritesMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      wasAdded ? "marked as fav" : "removed from favorites"),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: Colors.amber,
                key: ValueKey(isFavorite),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'ingredients',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final ing in meal.ingredients)
              Text(ing,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(
              height: 14,
            ),
            Text(
              'steps:',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 14,
            ),
            for (final stp in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(stp,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground)),
              ),
          ],
        ),
      ),
    );
  }
}
