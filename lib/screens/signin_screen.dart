import 'package:flutter/material.dart';
import 'package:voice_assistant/screens/signup_screen.dart';
import 'package:voice_assistant/utils/color_utils.dart';
import 'package:voice_assistant/reuseable_widgets/reuseable_widget.dart';
import 'package:voice_assistant/screens/Home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voice_assistant/screens/google_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}
class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  String? _emailErrorText; // Error text for email
  String? _passwordErrorText; // Error text for password
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB22B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.1,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                logoWidget("assets/logo1.png"),
                SizedBox(
                  height: 20,
                ),
                reuseableTextField(
                  "Enter Email",
                  Icons.email_outlined,
                  false,
                  _emailTextController,
                  errorText: _emailErrorText,
                ),
                SizedBox(
                  height: 20,
                ),
                reuseableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                  errorText: _passwordErrorText,
                  isObscure: _isObscure,
                  togglePasswordVisibility: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(
                  context,
                  true,
                      () async {
                    // Reset error messages
                    setState(() {
                      _emailErrorText = null;
                      _passwordErrorText = null;
                    });

                    // Validate email format
                    if (!_isValidEmail(_emailTextController.text.trim())) {
                      setState(() {
                        _emailErrorText = 'Invalid email format.';
                      });
                      return;
                    }

                    // Validate password length
                    if (_passwordTextController.text.trim().length < 6) {
                      setState(() {
                        _passwordErrorText = 'Password should be a minimum of six characters.';
                      });
                      return;
                    }

                    try {
                      UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailTextController.text.trim(),
                        password: _passwordTextController.text.trim(),
                      );
                      // Navigate to home page after successful sign-in
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        _emailErrorText = 'Wrong email or password.';
                        _passwordErrorText = 'Wrong email or password.';
                      });
                    }
                  },
                ),
                SizedBox(height: 10), // Add some spacing
                signUpOption(),
                SizedBox(height: 10), // Add some spacing
                GoogleOption(), // Add Google option
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Row GoogleOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Continue with ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () async {
            try {
              final GoogleSignInProvider googleSignInProvider = GoogleSignInProvider();
              final UserCredential userCredential = await googleSignInProvider.signInWithGoogle();
              if (userCredential != null) {
                // Navigate to home page after successful sign-in
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              }
            } catch (error) {
              // Handle sign-in errors
              print('Error signing in with Google: $error');
            }
          },
          child: const Text(
            "Google",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  bool _isValidEmail(String email) {
    // Simple email format validation
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
