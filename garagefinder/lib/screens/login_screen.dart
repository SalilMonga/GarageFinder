import 'package:flutter/material.dart';
import '../widgets/header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  bool _isLoginButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _emailError = isValidEmail(_emailController.text)
            ? null
            : 'Invalid email address';
        _validateInputs();
      });
    });
    _passwordController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      _isLoginButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          isValidEmail(_emailController.text) &&
          _emailError == null;
    });
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(), // Reusing the red header
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Username (Email)',
                    border: const OutlineInputBorder(),
                    errorText: _emailError,
                  ),
                  keyboardType: TextInputType.emailAddress,
                )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Hides the password
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoginButtonEnabled
                  ? () {
                      // Add login logic here
                    }
                  : null,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
