class SportVenue{
  final String typeOfSport;
  final String title;
  final int number;
  final int capacity;
  final String availablePeroids;
  final String state;
  final List<dynamic> imagesNames;

  const SportVenue({
    required this.typeOfSport,
    required this.title,
    required this.number,
    required this.capacity,
    required this.availablePeroids,
    required this.state,
    required this.imagesNames
      });

  static SportVenue fromJson(Map<String, dynamic> map){
    return SportVenue(typeOfSport: map['typeOfSport'],
        title: map['title'],
        number: map['number'],
        capacity: map['venueCapacity'],
        availablePeroids: map['availablePeriods'],
        state: map['venueState'],
        imagesNames: map['imagesNames']
    );
  }
}