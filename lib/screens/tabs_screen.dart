import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal/providers/favorite_provider.dart';
import 'package:meal/providers/filters_provider.dart';
import 'package:meal/providers/nav_bar_provider.dart';
import 'package:meal/screens/categories_screnen.dart';
import 'package:meal/screens/filterScreen.dart';
import 'package:meal/screens/meals_screen.dart';
import 'package:meal/widgets/main_drawer.dart';

class TabsScreen extends ConsumerWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget acgtiveScreen = CategoriesScreen(
      avialableMeals: availableMeals,
    );
    var activePageTitle = 'Pick Your Category';
    final selectedPageIndex = ref.watch(navBarProvider);
    if (selectedPageIndex == 1) {
      final fav = ref.watch(favoritesMealsProvider);
      acgtiveScreen = MealsScreen(
        meals: fav,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: acgtiveScreen,
      drawer: MainDrawer(
        onSelectScreen: (String identifier) {
          {
            if (identifier == 'filters') {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return const FiltersScreen();
              }));
            } else {
              Navigator.pop(context);
            }
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: ref.read(navBarProvider.notifier).selectPage,
          currentIndex: selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorite'),
          ]),
    );
  }
}
