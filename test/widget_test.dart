import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/auth_service.dart';
import 'package:flutter_testing/login_page.dart';

import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements AuthService {}

void main() {
  Widget createWidget(Widget child) {
    return MaterialApp(home: child);
  }

  group('Authentication check', () {
    testWidgets(
        'Given invalid credentials When user login Then verify credentials',
        (WidgetTester tester) async {
      MockAuth mockAuth = MockAuth();
      when(mockAuth.login('test@gmail.in', 'test1234'))
          .thenAnswer((invocation) => false);

      await tester.pumpWidget(createWidget(LoginPage(auth: mockAuth)));
      final StatefulElement element = tester.element(find.byType(LoginPage));
      final state = element.state as LoginPageState;
      expect(state.isSignedIn, isFalse);

      Finder email = find.byKey(const Key('email'));
      await tester.enterText(email, 'test@gmail.in');

      Finder password = find.byKey(const Key('password'));
      await tester.enterText(password, 'test1234');

      Finder login = find.byType(ElevatedButton);
      await tester.tap(login);
      await tester.pump();

      expect(state.isSignedIn, isFalse);
    });

    testWidgets(
        'Given valid credentials When user login Then verify credentials',
        (WidgetTester tester) async {
      MockAuth mockAuth = MockAuth();
      when(mockAuth.login('eve.holt@reqres.in', 'cityslicka'))
          .thenAnswer((invocation) => true);

      await tester.pumpWidget(createWidget(LoginPage(auth: mockAuth)));
      final StatefulElement element = tester.element(find.byType(LoginPage));
      final state = element.state as LoginPageState;
      expect(state.isSignedIn, isFalse);

      Finder email = find.byKey(const Key('email'));
      await tester.enterText(email, 'eve.holt@reqres.in');

      Finder password = find.byKey(const Key('password'));
      await tester.enterText(password, 'cityslicka');

      Finder login = find.byType(ElevatedButton);
      await tester.tap(login);
      await tester.pump();

      expect(state.isSignedIn, isTrue);
    });
  });
}
