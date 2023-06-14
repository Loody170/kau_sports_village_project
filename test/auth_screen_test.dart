import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kau_sports_village_project/screens/auth_screen.dart';

void main() {
  testWidgets('AuthScreen toggleScreens', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AuthScreen()));

    // // Verify initial state: SignInScreen is displayed
    // expect(find.byKey(ValueKey('signInScreen')), findsOneWidget);
    // expect(find.byKey(ValueKey('signUpScreen')), findsNothing);

    // // Tap on the toggle button to switch to SignUpScreen
    // await tester.tap(find.byKey(ValueKey('toggleButton')));
    // await tester.pump();
    //
    // // Verify state after switching: SignUpScreen is displayed
    // expect(find.byKey(ValueKey('signInScreen')), findsNothing);
    // expect(find.byKey(ValueKey('signUpScreen')), findsOneWidget);
    //
    // // Tap on the toggle button again to switch back to SignInScreen
    // await tester.tap(find.byKey(ValueKey('toggleButton')));
    // await tester.pump();
    //
    // // Verify state after switching: SignInScreen is displayed
    // expect(find.byKey(ValueKey('signInScreen')), findsOneWidget);
    // expect(find.byKey(ValueKey('signUpScreen')), findsNothing);
  });
}
