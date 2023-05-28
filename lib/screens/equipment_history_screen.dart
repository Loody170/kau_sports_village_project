import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/widgets/equipment_history_card.dart';

class EquipmentHistoryScreen extends StatelessWidget {
  static const routeName = '/equipment-history';
  static final List<String> _equipmentsNames = List.filled(5, '');

  static bool checkIfEquipmentExists(String equipmentName) {
    return _equipmentsNames.contains(equipmentName);
  }

  static void addEquipmentName(String equipmentName) {
    if(checkIfEquipmentExists(equipmentName)) {
      return;
    }
    for (int i = _equipmentsNames.length - 1; i > 0; i--) {
      _equipmentsNames[i] = _equipmentsNames[i - 1];
    }
    _equipmentsNames[0] = equipmentName;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Scanned Equipment History'),),
      body: Column(children:
      _equipmentsNames.map((listItem) {
        if(listItem.isNotEmpty){
          return EquipmentHistoryCard(equipmentName: listItem,);
        }
        return SizedBox.shrink();
      }).toList()

      ),);
  }
}
