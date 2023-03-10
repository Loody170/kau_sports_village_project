import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/screens/sport_venues_screen.dart';

class CategoryItem extends StatelessWidget {
  late final String title;
  late final Color color;
  late final String type;

  CategoryItem(this.type, this.title, this.color);

  void selectCategory(BuildContext ctx){
    Navigator.of(ctx).pushNamed(SportVenuesScreen.routeName, arguments: {'type': type, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: () => selectCategory(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),

        child: Container(padding: const EdgeInsets.all(15),
          child: Text(title, style: Theme.of(context).textTheme.headline6,),
          decoration: BoxDecoration(gradient: LinearGradient(colors:[color.withOpacity(0.7), color], begin: Alignment.topLeft, end: Alignment.bottomRight,),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      )
    ;
  }
}
