import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favoritesMeals;

  const TabsScreen({Key key, this.favoritesMeals}) : super(key: key);


  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState (){

    _pages  = [
      {
        'page' : const CategoriesScreen(),
        'title' : 'Categories',
      },
      {
        'page' :  FavoritesScreen(favoritesMeals: widget.favoritesMeals),
        'title' : 'Your Favorites',
      },
    ];
    super.initState();
  }

  void _selectPage(int value) {
    setState((){
      _selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title']),),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.star),
            label: "Favorites",
          ),

        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
