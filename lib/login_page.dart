import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'home_page.dart';
import 'utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.auth});

  final AuthService auth;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isSignedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const FlutterLogo(size: 80),
              Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      key: const Key('email'),
                      controller: emailController,
                      validator: (value) => Validator().validateEmail(value),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter Email',
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      key: const Key('password'),
                      controller: passwordController,
                      validator: (value) => Validator().validatePassword(value),
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter Password',
                        labelText: 'Password',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    setState(() => isLoading = true);
                    isSignedIn = await widget.auth.login(
                      emailController.text,
                      passwordController.text,
                    );
                    setState(() => isLoading = false);
                    if (mounted) {
                      if (isSignedIn) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const HomePage()),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Incorrect email or password.\nPlease try again!'),
                          ),
                        );
                      }
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
