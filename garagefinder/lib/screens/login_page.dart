import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garagefinder/components/text_field.dart';
import 'package:garagefinder/components/primary_button.dart';
import 'package:garagefinder/screens/organization_layout/organization_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // void _validateAndLoginNoFireBase() {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const OrganizationsPage(),
  //       ),
  //     );
  //     FocusScope.of(context).unfocus();
  //   }
  // }

  void _validateAndLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Sign in with email and password
        final userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _usernameController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Navigate to OrganizationsPage on successful login
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const OrganizationsPage(),
        //   ),
        // );
        Navigator.pushNamed(context, '/homepage');
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else {
          errorMessage = 'An unexpected error occurred. Please try again.';
        }

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    }
    FocusScope.of(context).unfocus(); // Hide keyboard
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Finder App'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight - MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _usernameController,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    // helperText: "Don't use special characters",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    helperText: 'Minimum 8 characters',
                    obscureText: true,
                    showSuffixIcon: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimaryButton(
                          text: 'Sign Up',
                          isOutlined: true,
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          }),
                      PrimaryButton(
                        text: 'Login',
                        onPressed: _validateAndLogin,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back!',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Login to access the full features',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
