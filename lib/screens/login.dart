import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gadgethome/component/background.dart';
import 'package:gadgethome/constants/constants.dart';
import 'package:gadgethome/controllers/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  void change(UserProvider controller) {
    if (controller.loggedIn) {
      Navigator.popAndPushNamed(context, MAIN_UI);
    } else {
      loading = false;
      AlertDialog alert =
          const AlertDialog(content: Text("Invalid credentials!!"));
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget textField(String text, Size size, TextEditingController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: size.height * 0.03),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: text),
            keyboardType: text == "Password"
                ? TextInputType.visiblePassword
                : TextInputType.name,
          ),
        )
      ],
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(80.0),
    ),
  );

  final snackBar = SnackBar(
    duration: const Duration(seconds: 5),
    content: Row(
      children: const <Widget>[
        Center(child: CircularProgressIndicator()),
        Text("  Signing-In...")
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserProvider>(
      builder: (context, controller, child) {
        Size size = MediaQuery.of(context).size;

        if (loading) {
          print("loading");
          Timer(const Duration(seconds: 5), () {
            change(controller);
          });
        }

        if (controller.loggedIn) {
          Navigator.popAndPushNamed(context, MAIN_UI);
        }

        return Scaffold(
          key: _scaffoldKey,
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Background(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2661FA),
                            fontSize: 36),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    textField("Username", size, usernameController),
                    textField("Password", size, passwordController),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: const Text(
                        "Forgot your password?",
                        style:
                            TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          controller.loginUser(
                              usernameController.text, passwordController.text);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          setState(() {
                            loading = true;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: size.width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                              gradient: const LinearGradient(colors: [
                                Color.fromARGB(255, 255, 136, 34),
                                Color.fromARGB(255, 255, 177, 41)
                              ])),
                          padding: const EdgeInsets.all(0),
                          child: const Text(
                            "LOGIN",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(REGISTRATION_SCREEN),
                        child: const Text(
                          "Don't Have an Account? Sign up",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2661FA)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
