import 'package:flutter/material.dart';
import 'models/category.dart';

const CATEGORIES = const [
  SportsCategory(type: 'FB', title: 'Football', color: Colors.green, icon: 'https://i.imgur.com/7G75q9z.png'),
  SportsCategory(type: 'BB', title: 'Basketball', color: Colors.deepOrange, icon: 'https://i.imgur.com/J5Bh1GF.png'),
  SportsCategory(type: 'VB', title: 'Volleyball', color: Color.fromRGBO(255, 175, 0, 1), icon: 'https://i.imgur.com/ca3y9nJ.png'),
  SportsCategory(type: 'ST', title: 'Squash Tennis', color: Colors.red, icon: 'https://i.imgur.com/qIUH8Wb.png'),
  // SportsCategory(type: 'SW', title: 'Swimming', color: Colors.blue),
];
