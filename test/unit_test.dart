import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/utils.dart';

void main() {
  group('Validation check', () {
    test('Given invalid email When user login Then validate email', () {
      final validator = Validator();
      final emailValidator = validator.validateEmail('');
      expect(emailValidator, 'Invalid email');
    });

    test('Given valid email When user login Then validate email', () {
      final validator = Validator();
      final emailValidator = validator.validateEmail('test@gmail.com');
      expect(emailValidator, null);
    });

    test('Given invalid password When user login Then validate password', () {
      final validator = Validator();
      final emailValidator = validator.validatePassword('');
      expect(emailValidator, 'Short password');
    });

    test('Given valid password When user login Then validate password', () {
      final validator = Validator();
      final emailValidator = validator.validatePassword('test1234');
      expect(emailValidator, null);
    });
  });
}
