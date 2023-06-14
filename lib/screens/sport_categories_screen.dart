import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/widgets/category_item.dart';

import '../app_data.dart';

class SportCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(padding: const EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200,
          childAspectRatio: 2/ 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10), children:
      CATEGORIES.map((catData) => CategoryItem(
          catData.type,
          catData.title,
          catData.color,
      catData.icon))
          .toList(),
    );
  }
}

