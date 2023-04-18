class AppUser {

  late String email;
  late String fName;
  late String lName;
  late String department;
  late String kauID;
  late String phoneNum;
  late String role;
  late String height;
  late String weight;


  AppUser({
    required this.email, required this.fName,
    required this.lName, required this.department,
    required this.kauID, required this.phoneNum,
    required this.role, required this.height,
    required this.weight
});

  static AppUser fromJson(Map<String, dynamic> map){
    return AppUser(
        email: map['Email'],
        fName: map['First Name'],
        lName: map['Last Name'],
        phoneNum: map['Phone Number'],
        role: map['Role'],
        kauID: map['KAU ID'],
        department: map['Department'],
        height: map['Height'],
        weight: map['Weight']
    );
  }

}