import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/auth_service.dart';
import 'package:flutter_testing/login_page.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements AuthService {}

void main() {
  late final AuthService mockAuth;

  setUpAll(() => mockAuth = MockAuth());

  Widget createWidget(Widget child) => MaterialApp(home: child);

  group('Authentication check', () {
    testWidgets(
        'Given invalid credentials When user login Then verify credentials',
        (WidgetTester tester) async {
      when(mockAuth.login('test@gmail.in', 'test1234'))
          .thenAnswer((invocation) => false);
      await tester.pumpWidget(createWidget(LoginPage(auth: mockAuth)));

      /// ARRANGE
      final StatefulElement element = tester.element(find.byType(LoginPage));
      final LoginPageState state = element.state as LoginPageState;
      final Finder email = find.byKey(const Key('email'));
      final Finder password = find.byKey(const Key('password'));
      final Finder login = find.byType(ElevatedButton);

      /// ACT
      await tester.enterText(email, 'test@gmail.in');
      await tester.enterText(password, 'test1234');
      await tester.tap(login);
      await tester.pump();

      /// ASSERT
      expect(state.isSignedIn, isFalse);
    });

    testWidgets(
        'Given valid credentials When user login Then verify credentials',
        (WidgetTester tester) async {
      when(mockAuth.login('eve.holt@reqres.in', 'cityslicka'))
          .thenAnswer((invocation) => true);
      await tester.pumpWidget(createWidget(LoginPage(auth: mockAuth)));

      /// ARRANGE
      final StatefulElement element = tester.element(find.byType(LoginPage));
      final LoginPageState state = element.state as LoginPageState;
      final Finder email = find.byKey(const Key('email'));
      final Finder password = find.byKey(const Key('password'));
      final Finder login = find.byType(ElevatedButton);

      /// ACT
      await tester.enterText(email, 'eve.holt@reqres.in');
      await tester.enterText(password, 'cityslicka');
      await tester.tap(login);
      await tester.pump();

      /// ASSERT
      expect(state.isSignedIn, isTrue);
    });
  });
}
