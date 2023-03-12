import 'package:flutter/material.dart';

class ReservationForm extends StatefulWidget {
  late int venueCapacity;
  String label = '';
  late Map formData;
  List listOfPlayers = [];

  Map initMap(){
    Map map = {};
    for (int i =0; i< venueCapacity; i++){
      map['Player ${i+1}'] = '';
      map['ID ${i+1}'] = '';
    }
    return map;
  }

  void updateMap(List l, Map map,){
    int index = 0;
    map.keys.forEach((key) {
      map.update(key, (value) => l[index]);
      index++;
    });
  }

  List<Widget> makeFields(){
    List <Widget> fields = [];
    formData = initMap();
    for (int i =0; i< venueCapacity; i++){
      label = 'Player ${i+1}';
      fields.add(Row(children: [
        Expanded(child: Padding(padding: EdgeInsets.all(10),
          child: TextFormField(decoration: InputDecoration(labelText:label,),
            textInputAction: TextInputAction.next,
            validator: (value){
              RegExp fullNameRegex = RegExp(r'^[a-zA-Z]+(\s[a-zA-Z]+)+$');
              if(!fullNameRegex.hasMatch(value as String))
                return 'Entered name is invalid';
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onSaved: (value){
              listOfPlayers.add(value);
            },
          ),
        ),
        ),
        SizedBox(width: 10),
        Expanded(child: TextFormField(decoration: InputDecoration(labelText: 'University ID',),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          onSaved: (value){
            listOfPlayers.add(value);
          },),
        ),
      ],)
      );
    }//for loop
    return fields;
  }

  ReservationForm(this.venueCapacity);

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final _form = GlobalKey<FormState>();

  void saveForm(){
    _form.currentState?.save();

  }

  @override
  Widget build(BuildContext context) {
    print('the form will have ${widget.venueCapacity}' );
    return Padding(padding: EdgeInsets.all(16),
    child: Form(key: this._form,
      child: SingleChildScrollView(
      child: Column(
        children: [
          Column(children:
            this.widget.makeFields()
          ),
          ElevatedButton(onPressed: (){
            this.saveForm();
            //print(this.widget.l);
            this.widget.updateMap(this.widget.listOfPlayers, this.widget.formData, );
            print('map is :');
            print(this.widget.formData);
          }, child: Text('Confirm'))
        ],
      ),
    ),),
    );
  }
}
