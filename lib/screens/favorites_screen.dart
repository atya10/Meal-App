import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {

  final List<Meal> favoritesMeals;

  const FavoritesScreen({Key key, this.favoritesMeals}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    if (favoritesMeals.isEmpty){
      return const Center(
        child: Text(
          "You have no favorites yet - start adding some!",
        ),
      );
    }
    else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return
            MealItem(
              id:   favoritesMeals[index].id,
              title:  favoritesMeals[index].title,
              imageUrl: favoritesMeals[index].imageUrl,
              duration:  favoritesMeals[index].duration,
              complexity:  favoritesMeals[index].complexity,
              affordability: favoritesMeals[index].affordability,
            );
        },
        itemCount: favoritesMeals.length,
      );
    }

  }
}
