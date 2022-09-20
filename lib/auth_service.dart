import 'package:http/http.dart';

class AuthService {
  login(email, password) async {
    final response = await post(
      Uri.https("reqres.in", "api/login"),
      body: {"email": email, "password": password},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
