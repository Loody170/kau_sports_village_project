import 'package:flutter/material.dart';

class GymEquipment {
  late final String name;
  late final String description;
  late final List<dynamic> workoutTips;

  GymEquipment({
    required this.name, required this.description,
    required this.workoutTips,
  });


  static GymEquipment fromJson(Map<String, dynamic> map,){
    return GymEquipment(
        name: map['name'],
        description: map['description'],
        workoutTips: map['workoutTips'],
    );
  }
}