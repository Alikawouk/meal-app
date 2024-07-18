// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     if (identifier == 'meals') {
      //       Navigator.pop(context);
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) {
      //             return const TabsScreen();
      //           },
      //         ),
      //       );
      //     }
      //     ;
      //   },
      // ),

      body: Column(
        children: [
          customSwitch(
              context,
              'Gluten Free ',
              'only contain   Gluten Free meals',
              activeFilters[Filter.glutenFree]!, (newValue) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.glutenFree, newValue);
          }),
          customSwitch(
              context,
              'LactoseFree  ',
              'only contain   lactose Free meals',
              activeFilters[Filter.lactoseFree]!, (newValue) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.lactoseFree, newValue);
          }),
          customSwitch(context, 'Vegan ', 'only contain    Vegan meals',
              activeFilters[Filter.vegan]!, (newValue) {
            ref
                .read(filtersProvider.notifier)
                .setFilter(Filter.vegan, newValue);
          }),
          customSwitch(
            context,
            'Vegeterian ',
            'only contain   Vegeterian meals',
            activeFilters[Filter.vegetarian]!,
            (newValue) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, newValue);
            },
          ),
        ],
      ),
    );
  }

  SwitchListTile customSwitch(BuildContext context, title, subtitle,
      bool filter, Function(bool newValue) onchange) {
    return SwitchListTile(
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        activeColor: Theme.of(context).colorScheme.tertiary,
        contentPadding: const EdgeInsets.only(left: 34, right: 22),
        value: filter,
        onChanged: onchange);
  }
}
