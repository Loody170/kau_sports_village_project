import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kau_sports_village_project/screens/sport_venues_screen.dart';

class CategoryItem extends StatelessWidget {
  late final String title;
  late final Color color;
  late final String type;
  late final String icon;

  CategoryItem(this.type, this.title, this.color, this.icon);

  void selectCategory(BuildContext ctx){
    Navigator.of(ctx).pushNamed(
        SportVenuesScreen.routeName, arguments: {'type': type, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: () => selectCategory(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),

        child: Container(padding: const EdgeInsets.all(15),
          child: Stack(children:[


    Transform.scale(
      scale: 0.8,
      child: Transform.translate(
      offset: Offset(30.0, -5.0),
      child: Transform.rotate(
      angle: 1.5, // rotate 180 degrees in radians
      child: Image.asset(
      icon,
      fit: BoxFit.cover,
      )
      )
      ),
    )
      ,



          Text(title,
            style: GoogleFonts.raleway(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),

          ])
        ,
          decoration: BoxDecoration(gradient: LinearGradient(colors:[color.withOpacity(0.7), color], begin: Alignment.topLeft, end: Alignment.bottomRight,),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      )
    
    ;
  }
}
