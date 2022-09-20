import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/auth_service.dart';
import 'package:flutter_testing/login_page.dart';
import 'package:flutter_testing/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements AuthService {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late final AuthService mockAuth;

  setUpAll(() => mockAuth = MockAuth());

  group('Complete app test', () {
    testWidgets('Tap on the elevated button, to verify empty login',
        (tester) async {
      when(mockAuth.login('', '')).thenAnswer((invocation) => false);

      app.main();
      await tester.pumpAndSettle();

      /// ARRANGE
      final StatefulElement element = tester.element(find.byType(LoginPage));
      final LoginPageState state = element.state as LoginPageState;
      final Finder email = find.byKey(const Key('email'));
      final Finder password = find.byKey(const Key('password'));
      final Finder login = find.byType(ElevatedButton);

      /// ACT
      await tester.enterText(email, '');
      await tester.enterText(password, '');
      await tester.tap(login);
      await tester.pumpAndSettle();

      /// ASSERT
      expect(state.isSignedIn, isFalse);
    });
    testWidgets('Tap on the elevated button, to verify invalid login',
        (tester) async {
      when(mockAuth.login('test@gmail.in', 'test1234'))
          .thenAnswer((invocation) => false);

      app.main();
      await tester.pumpAndSettle();

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
      await tester.pumpAndSettle();

      /// ASSERT
      expect(state.isSignedIn, isFalse);
    });

    testWidgets('Tap on the elevated button, to verify valid login',
        (tester) async {
      when(mockAuth.login('eve.holt@reqres.in', 'cityslicka'))
          .thenAnswer((invocation) => true);

      app.main();
      await tester.pumpAndSettle();

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
      await tester.pumpAndSettle();

      /// ASSERT
      expect(state.isSignedIn, isTrue);
    });
  });
}
