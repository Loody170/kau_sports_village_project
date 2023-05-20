import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/widgets/venue_item.dart';

import '../screens/reservation_confirmation_screen.dart';

class ReservationForm extends StatefulWidget {
  late List receivedArgs;
  late int venueCapacity = (receivedArgs[0] as VenueItem).capacity;
  String label = '';
  late Map formData;
  List listOfPlayers = [];

  ReservationForm(this.receivedArgs,);

  Map initMap(){
    Map map = {};
    // for (int i =0; i< venueCapacity; i++){
    //   map['Player ${i+1}'] = '';
    //   map['ID ${i+1}'] = '';
    // }
    return map;
  }

  void updateMap(List l, Map map,){
    // int index = 0;
    // map.keys.forEach((key) {
    //   map.update(key, (value) => l[index]);
    //   index++;
    // });
    for(int i = 0; i<l.length; i+= 2){
      map[l[i]] = l[i+1];
    }
  }

  List<Widget> makeFields(){
    List <Widget> fields = [];
    formData = initMap();
    for (int i =0; i< venueCapacity; i++){
      label = 'Player ${i+1}';
      fields.add(Row(children: [
        Expanded(child: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: TextFormField(
            decoration: InputDecoration(labelText:label,),
            textInputAction: TextInputAction.next,
            validator: (value){
            if((value as String)=='') {
              print('no name provided');
              print(value);
              return 'Player name can\'t be empty';
            }
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
        Expanded(child: Padding(
          padding: EdgeInsets.only(left: 25),
          child: TextFormField(decoration: InputDecoration(labelText: 'University ID',),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            validator: (value){
              if((value as String)=='') {
                print('no number provided');
                print(value);
                return 'University ID can\'t be empty';
              }
              RegExp numberRegex = RegExp(r'^[1-2]\d{6}$');
              if(!numberRegex.hasMatch(value as String)){
                return 'Entered University ID is invalid';
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onSaved: (value){
              listOfPlayers.add(value);
            },),
        ),
        ),
      ],)
      );
    }//for loop
    return fields;
  }


  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final _form = GlobalKey<FormState>();

  void saveForm(){
    _form.currentState?.save();
  }
  bool validateForm(){
    bool? v =_form.currentState?.validate();
    if(!v!)
      return false;
    else
      return true;
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
          Padding(
            padding: EdgeInsets.all(30),
            child: ElevatedButton(onPressed: (){
              if(!this.validateForm())
                return;
              else {
                print('yaaaaay');
                this.saveForm();
                this.widget.updateMap(this.widget.listOfPlayers, this.widget.formData, );
                print('map is :');
                print(this.widget.formData);
              }
              Navigator.of(context).pushNamed(ReservationConfirmationScreen.routeName, arguments: [
                this.widget.receivedArgs,
                this.widget.formData
              ]);
            }, child: Text('Confirm')),
          )
        ],
      ),
    ),),
    );
  }
}
