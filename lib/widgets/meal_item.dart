import 'package:flutter/material.dart';
import 'package:meal/model/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onselectMeal});
  final Meal meal;
  final void Function(Meal meal) onselectMeal;
  String get compelxityText {
    switch (meal.complexity) {
      case Complexity.simple:
        return 'simple';

      case Complexity.challenging:
        return 'challenging';
      case Complexity.hard:
        return 'hard';

      default:
        return 'unknown';
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.affordable:
        return 'affordable';

      case Affordability.luxurious:
        return 'luxurious';
      case Affordability.pricey:
        return 'pricey';

      default:
        return 'unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () => onselectMeal(meal),
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.schedule),
                              const SizedBox(
                                width: 10,
                              ),
                              Text("${meal.duration} min")
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.work),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(compelxityText)
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.attach_money),
                              const SizedBox(
                                width: 1,
                              ),
                              Text(affordabilityText)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
