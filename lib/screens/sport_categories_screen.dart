import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/widgets/category_item.dart';

import '../dummy_data.dart';

class SportCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(padding: const EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20), children:
      DUMMY_CATEGORIES.map((catData) => CategoryItem(
          catData.type,
          catData.title,
          catData.color))
          .toList(),
    );
  }
}
