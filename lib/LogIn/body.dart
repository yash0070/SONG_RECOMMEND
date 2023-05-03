import 'package:chat_bot/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../SignUp/signUp_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final emailField = TextFormField(
      autofocus: false,
      controller: _email,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Email required";
        } else {
          return null;
        }
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: Color(0xff4169E1),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF778A1), width: 2),
          borderRadius: BorderRadius.circular(32),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF778A1), width: 1),
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );

    // passwordField
    final passField = TextFormField(
      autofocus: false,
      controller: _password,
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password required";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.vpn_key,
          color: Color(0xff4169E1),
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF778A1), width: 2),
          borderRadius: BorderRadius.circular(32),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF778A1), width: 1),
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(32),
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.1),
                const Text(
                  "LogIn",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.04),
                Image.asset(
                  "assets/images/music.png",
                  height: 150,
                ),
                SizedBox(height: size.height * 0.03),
                emailField,
                SizedBox(height: size.height * 0.03),
                passField,
                SizedBox(height: size.height * 0.03),
                GestureDetector(
                  onTap: () {
                    if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    } else {
                      Fluttertoast.showToast(msg: "Please Enter Details");
                    }
                  },
                  child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [
                            // Color(0xffF778A1),
                            Color.fromRGBO(65, 105, 225, 1),
                            Color(0xffF778A1),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          stops: [0.4, 0.7],
                          tileMode: TileMode.repeated,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        "LogIn",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ))),
                ),
                SizedBox(height: size.height * 0.02),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " Don't have an acoount? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationScreen()));
                          });
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                            color: Color(0xffF778A1),
                          ),
                        )),
                  ],
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
