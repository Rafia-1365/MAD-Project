import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.cover,
    width: 300,
    height: 240,
  );
}

TextField reuseableTextField(
    String text,
    IconData icon,
    bool isPasswordType,
    TextEditingController controller, {
      String? errorText,
      Function()? togglePasswordVisibility,
      bool isObscure = false, // Set isObscure to false to make text visible
      bool isEmail = false,
    }) {
  return TextField(
    controller: controller,
    obscureText: isObscure,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      suffixIcon: isPasswordType
          ? GestureDetector(
        onTap: togglePasswordVisibility,
        child: Icon(isObscure
            ? Icons.visibility
            : Icons.visibility_off),
      )
          : null,
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      errorText: errorText,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : (isEmail ? TextInputType.emailAddress : TextInputType.text),
  );
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(8, 18, 8, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}
