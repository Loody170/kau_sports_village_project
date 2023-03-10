import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTiles(String title, IconData icon, VoidCallback tapHandler){
    return ListTile(leading: Icon(icon, size: 26,), title: Text(title, style: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 24, fontWeight: FontWeight.bold),),
      onTap: tapHandler ,);
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Column(children: [
      Container(color: Theme.of(context).accentColor, height: 120, width: double.infinity, padding: EdgeInsets.all(20), alignment: Alignment.centerLeft,
        child: Text('Side Bar!', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: Theme.of(context).primaryColor),)
        ,),
      SizedBox(height: 20,),
      buildListTiles('Sports Categories', Icons.sports_handball, (){Navigator.of(context).pushReplacementNamed('/');}),

    ],),
    );
  }
}
