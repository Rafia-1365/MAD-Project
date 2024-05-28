import 'package:flutter/material.dart';
import 'package:voice_assistant/reuseable_widgets/reuseable_widget.dart';
import 'package:voice_assistant/utils/color_utils.dart';
import 'package:voice_assistant/screens/Home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voice_assistant/screens/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _repasswordTextController = TextEditingController();

  String? _usernameErrorText;
  String? _emailErrorText;
  String? _passwordErrorText;
  String? _repasswordErrorText;

  bool _isObscure = true;
  bool _isRepasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
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
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                reuseableTextField(
                  "Enter Username",
                  Icons.person_outline,
                  false,
                  _usernameTextController,
                  errorText: _usernameErrorText,
                ),
                const SizedBox(height: 20),
                reuseableTextField(
                  "Enter Email ID",
                  Icons.email_outlined,
                  false,
                  _emailTextController,
                  errorText: _emailErrorText,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                reuseableTextField(
                  "Re-enter Password ",
                  Icons.lock_outline,
                  true,
                  _repasswordTextController,
                  errorText: _repasswordErrorText,
                  isObscure: _isRepasswordObscure,
                  togglePasswordVisibility: () {
                    setState(() {
                      _isRepasswordObscure = !_isRepasswordObscure;
                    });
                  },
                ),
                const SizedBox(height: 20),
                signInSignUpButton(context, false, () async {
                  setState(() {
                    if (_usernameTextController.text.isEmpty) {
                      _usernameErrorText = "Please enter your username";
                    } else {
                      _usernameErrorText = null;
                    }

                    if (_emailTextController.text.isEmpty) {
                      _emailErrorText = "Please enter your email id";
                    } else if (!_emailTextController.text.contains('@') ||
                        !_emailTextController.text.contains('.')) {
                      _emailErrorText = "Please enter a valid email address";
                    } else {
                      _emailErrorText = null;
                    }

                    if (_passwordTextController.text.isEmpty) {
                      _passwordErrorText = "Please enter your password";
                    } else {
                      _passwordErrorText = null;
                    }

                    if (_repasswordTextController.text.isEmpty) {
                      _repasswordErrorText = "Enter your password again";
                    } else if (_passwordTextController.text !=
                        _repasswordTextController.text) {
                      _repasswordErrorText = "Passwords do not match";
                    } else {
                      _repasswordErrorText = null;
                    }
                  });

                  if (_usernameErrorText == null &&
                      _emailErrorText == null &&
                      _passwordErrorText == null &&
                      _repasswordErrorText == null) {
                    try {
                      UserCredential userCredential =
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailTextController.text.trim(),
                        password: _passwordTextController.text.trim(),
                      );
                      // Navigate to home page after successful sign-up
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        setState(() {
                          _passwordErrorText = 'The password provided is too weak.';
                        });
                      } else if (e.code == 'email-already-in-use') {
                        setState(() {
                          _emailErrorText = 'The account already exists for that email.';
                        });
                      }
                    }
                  }
                }),
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
          "Already have an account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
            );
          },
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
