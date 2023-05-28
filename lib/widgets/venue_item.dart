import 'package:flutter/material.dart';
import 'package:kau_sports_village_project/screens/venue_booking_screen.dart';
import 'package:page_indicator/page_indicator.dart';

class VenueItem extends StatelessWidget {
  final String typeOfSport;
  final String title;
  final int number;
  final int capacity;
  final String availablePeroids;
  final String state;
  final List<dynamic> imagesNames;
  final int startingTime;
  final int endingTime;

  VenueItem({
    required this.typeOfSport,
    required this.title,
    required this.number,
    required this.capacity,
    required this.availablePeroids,
    required this.state,
    required this.imagesNames,
    required this.startingTime,
    required this.endingTime
  });


  void selectVenue(BuildContext context){
    Navigator.of(context).pushNamed(VenueBookingScreen.routeName,
        arguments: {'venueObject': this
    });

  }

  Widget makePageView(){
    return Expanded(
      child: PageView.builder(
        itemCount: imagesNames.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset('assets/sport_venues_images/${imagesNames[index]}.jpg',
            height: 300, width: double.infinity,
            fit: BoxFit.cover,);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (state == "closed")? 0.3 : 1.0,
      child: InkWell(
        onTap: (state == "closed")? null: () => selectVenue(context),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: PageIndicatorContainer(
                  child: PageView.builder(
                    itemBuilder: (context, index) {
                      return Stack(
                        children:[ ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          child: Image.asset(
                            'assets/sport_venues_images/${imagesNames[index]}.jpg',
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                          Positioned(bottom:20, right: 10, child: Container(
                            width: 300, color: Colors.black26,
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20), child: Text(
                            title + '#' + number.toString(), style: TextStyle(fontSize: 26, color: Colors.white,),
                            softWrap: true, overflow: TextOverflow.fade,),)),
                          if (state == "closed")
                            Center(
                              child: Container(
                                color: Colors.black,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Closed',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ]
                      );
                    },
                    itemCount: imagesNames.length,
                  ),
                  length: imagesNames.length,
                  align: IndicatorAlign.bottom,
                  indicatorSpace: 10.0,
                  indicatorSelectorColor: Colors.white,
                  indicatorColor: Colors.blueGrey,
                  shape: IndicatorShape.circle(size: 8),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.numbers),
                        SizedBox(
                          width: 6,
                        ),
                        Text(capacity.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.timelapse),
                        SizedBox(
                          width: 6,
                        ),
                        Text("$startingTime:00PM to $endingTime:00PM"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }
}