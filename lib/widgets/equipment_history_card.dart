import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/screens/equipment_information_screen.dart';

class EquipmentHistoryCard extends StatelessWidget {
  late String equipmentName;
  late String equipmentPicture;

  EquipmentHistoryCard({
    required this.equipmentName,
});

  Future<String> getImageUrl(String path) async {
    final ref = FirebaseStorage.instance.ref()
        .child(path);
    final url = await ref.getDownloadURL();
    return url.toString();
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(EquipmentInformationScreen.routeName, arguments: equipmentName);
        },
        child: Row(
          children: [
            FutureBuilder(
              future: getImageUrl('$equipmentName/$equipmentName.jpg'),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }
                else
                  return Text('Loading...');

              },

            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  equipmentName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
