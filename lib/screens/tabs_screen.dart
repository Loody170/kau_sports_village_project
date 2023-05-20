import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/screens/equipment_history_screen.dart';
import 'package:kau_sports_village_project/screens/gym_assistant_screen.dart';
import 'package:kau_sports_village_project/screens/sport_categories_screen.dart';

import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  static String routeName = '/tabs-screen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [
    {'page': SportCategoriesScreen(), 'title': 'Sport Categories'},
    {'page': GymAssistantScreen(), 'title': 'Gym Assistant'} //temp
    ,
    //{'page': FavoritesScreen(), 'title': 'Your Favorites'},
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title'].toString()),
        actions: _selectedPageIndex == 1?
        [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).pushNamed(EquipmentHistoryScreen.routeName);
            },
          )
        ]
            : null,
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,

        items: [
          BottomNavigationBarItem(backgroundColor:Theme.of(context).primaryColor,
              icon: Icon(Icons.sports_handball), label: 'Sports Categories'),
          BottomNavigationBarItem(backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.sports_gymnastics), label: 'Gym Assistant'),

        ],),
    );

  }
}
