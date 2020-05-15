import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onlinemandi_admin/methods.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailCont = TextEditingController();
  TextEditingController _passCont = TextEditingController();
  FirebaseMethods _methods = FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Image.asset(
                'images/welcome.png',
                height: 250.0,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _emailCont,
                      decoration: InputDecoration(
                          hintText: "Enter Email ID",
                          labelText: "Email ID",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35.0))),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: _passCont,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35.0))),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0)),
                      minWidth: MediaQuery.of(context).size.width - 20,
                      height: 40.0,
                      color: Colors.deepPurple,
                      onPressed: () async {
                        if (_emailCont.text != "" && _passCont.text != "") {
                          await _methods
                              .signIn(_emailCont.text, _passCont.text)
                              .then((user) {
                            if (user != null) {
                              Fluttertoast.showToast(msg: "Login success");
                              Navigator.pushReplacementNamed(context, '/home');
                            } else {
                              Fluttertoast.showToast(msg: "Wrong Password !");
                            }
                          });
                        } else {
                          Fluttertoast.showToast(msg: "Fill login details !");
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
