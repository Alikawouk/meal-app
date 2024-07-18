import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal/providers/meals_provider.dart';

enum Filter { glutenFree, vegetarian, vegan, lactoseFree }

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false
        });

  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilter = ref.watch(filtersProvider);
  return meals.where((element) {
    if (activeFilter[Filter.glutenFree]! && !element.isGlutenFree) {
      return false;
    }
    if (activeFilter[Filter.lactoseFree]! && !element.isLactoseFree) {
      return false;
    }

    if (activeFilter[Filter.vegan]! && !element.isVegan) {
      return false;
    }

    if (activeFilter[Filter.vegetarian]! && !element.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
