import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map <String , bool> _filters = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  final List<Meal> _favoritesMeals = [];

  void _setFilters (Map <String , bool> filtersData){

    setState ((){
      _filters = filtersData;

      _availableMeals = DUMMY_MEALS.where((meal) {
         if (_filters['gluten'] && !meal.isGlutenFree){
          return false;
        }
         if (_filters['lactose'] && !meal.isLactoseFree){
          return false;
        }
         if (_filters['vegan'] && !meal.isVegan){
          return false;
        }
         if (_filters['vegetarian'] && !meal.isVegetarian){
          return false;
        }
         return true;
      }).toList();
    });

  }

  void _toggleFavorites (String mealId){

    final existingIndex = _favoritesMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0){
      setState((){
        _favoritesMeals.removeAt(existingIndex);
      });
    }
    else {
      setState((){
        _favoritesMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _ismealFavorites (String id) {
    return _favoritesMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
          ),
          bodyText2: const TextStyle(
            color: Color.fromRGBO(20, 50, 50, 1),
          ),
          subtitle1: const TextStyle(
              fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
     // home: const MyHomePage(),
     // initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(favoritesMeals: _favoritesMeals),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(toggleFavorites: _toggleFavorites,isFavorites: _ismealFavorites),
        FiltersScreen.routeName: (context) => FiltersScreen(currentFilters: _filters, saveFilters: _setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal App"),
      ),
      body: null,
    );
  }
}
