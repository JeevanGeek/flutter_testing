import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/utils.dart';

void main() {
  late final Validator validator;

  /// ARRANGE
  setUpAll(() => validator = Validator());

  group('Validation check', () {
    test('Given invalid email When user login Then validate email', () {
      /// ACT
      final String? emailValidator = validator.validateEmail('');

      /// ASSERT
      expect(emailValidator, 'Invalid email');
    });

    test('Given valid email When user login Then validate email', () {
      /// ACT
      final String? emailValidator = validator.validateEmail('test@gmail.com');

      /// ASSERT
      expect(emailValidator, null);
    });

    test('Given invalid password When user login Then validate password', () {
      /// ACT
      final String? passwordValidator = validator.validatePassword('');

      /// ASSERT
      expect(passwordValidator, 'Short password');
    });

    test('Given valid password When user login Then validate password', () {
      /// ACT
      final String? passwordValidator = validator.validatePassword('test1234');

      /// ASSERT
      expect(passwordValidator, null);
    });
  });
}
