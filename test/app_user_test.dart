import 'package:flutter_test/flutter_test.dart';
import 'package:kau_sports_village_project/models/app_user.dart';

void main() {
  test('AppUser.fromJson() test', () {
    final Map<String, dynamic> json = {
      'Email': 'test@example.com',
      'First Name': 'Khalid',
      'Last Name': 'Sharafaldeen',
      'Phone Number': '0570113040',
      'Role': 'Student',
      'KAU ID': '1945522',
      'Department': 'IT',
      'Height': '',
      'Weight': '',
    };

    final AppUser user = AppUser.fromJson(json);

    expect(user.email, 'test@example.com');
      expect(user.fName, 'Khalid');
    expect(user.lName, 'Sharafaldeen');
    expect(user.phoneNum, '0570113040');
    expect(user.role, 'Student');
    expect(user.kauID, '1945522');
    expect(user.department, 'IT');
    expect(user.height, '');
    expect(user.weight, '');
  });
}
