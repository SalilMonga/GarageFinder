import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:garagefinder/components/text_field.dart';
import 'package:garagefinder/components/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // void _validateAndSignUpWithoutFirebase() {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     // Perform sign-up logic here
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Account created successfully!')),
  //     );
  //     FocusScope.of(context).unfocus();
  //     Navigator.pop(context); // Navigate back to login or another page
  //   }
  // }

  void _validateAndSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Create user with email and password
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Set display name (optional)
        await userCredential.user
            ?.updateDisplayName(_usernameController.text.trim());

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Welcome, ${_usernameController.text}! Account created successfully.')),
        );

        // Navigate to login or next page
        Navigator.pushNamed(context, '/organizations'); // Update as needed
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'email-already-in-use') {
          errorMessage = 'The email is already in use. Please try another one.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'The password is too weak.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The email address is invalid.';
        } else {
          errorMessage = 'An unexpected error occurred. Please try again.';
        }

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      } catch (e) {
        // Catch other errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An error occurred. Please try again later.')),
        );
      }
    }
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
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _usernameController,
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    helperText: "Don't use special characters",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
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
                  CustomTextField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    hintText: 'Enter your password again',
                    helperText: 'Minimum 8 characters',
                    obscureText: true,
                    showSuffixIcon: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: 'Sign Up',
                    onPressed: _validateAndSignUp,
                    fullWidth: true,
                    // isOutlined: true,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Navigate back to login page
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Already have an account? Login',
                          style: TextStyle(
                            color: Colors.grey, // Grey color for the text
                            decoration:
                                TextDecoration.underline, // Underline the text
                          ),
                        ),
                      ),
                    ),
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
