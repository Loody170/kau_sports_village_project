import 'package:flutter/material.dart';

class GymEquipment {
  late final String name;
  late final String description;
 // late final String picture;
  late final List<dynamic> workoutTips;
  //late final String workoutPicture;

  GymEquipment({
    required this.name, required this.description,
    //required this.picture,
    required this.workoutTips,
    //required this.workoutPicture
  });


  static GymEquipment fromJson(Map<String, dynamic> map,
      //String  pic, String workoutPic
      ){

    return GymEquipment(
        name: map['name'],
        description: map['description'],
       // picture: pic,
        workoutTips: map['workoutTips'],
        //workoutPicture: workoutPic
    );
  }



}