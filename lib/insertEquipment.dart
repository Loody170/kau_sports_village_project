import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kau_sports_village_project/models/gym_equipment.dart';
class insertEquipment{

  GymEquipment equipment1 =
  GymEquipment(
      name: 'Precor Vertical Knee Up',
      description: 'Vertical Knee Up supports a range of core and lower body exercises.',
      workoutTips: [
        'Start with a low weight or resistance setting when using the Precor Vertical Knee Up, especially if you are a beginner. This will help you get used to the motion and prevent injury. Gradually increase the weight or resistance as you become more comfortable and stronger.',
        'Before using the Precor Vertical Knee Up, make sure to adjust the machine to your height and ensure that it is stable. Avoid using the machine if it is wobbly or unstable.',
        'Maintaining proper form is crucial when using the Precor Vertical Knee Up. Keep your back straight, shoulders relaxed, and engage your core throughout the movement, while lifting your knees all the way up towards your chest without swinging your legs or using momentum.'
      ]);

  static addEquipment(GymEquipment equipment) {
    final collectionReference = FirebaseFirestore.instance.collection('gym_equipment_tips');

    collectionReference.doc(equipment.name).set({
      'name': equipment.name,
      'description': equipment.description,
      'workoutTips': equipment.workoutTips,
    });
  }
}
