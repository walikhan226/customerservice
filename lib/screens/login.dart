import 'dart:io';

import 'package:customerservice/constants/custom_colors.dart';
import 'package:customerservice/repositories/auth_repositories.dart';
import 'package:customerservice/screens/home_screen.dart';
import 'package:customerservice/screens/signup.dart';
import 'package:customerservice/widgets/alert_dialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double _width, _height;
  bool _isLoading = false;
  bool _passHidden = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User> handleSignIn() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    User firebaseUser = (await _auth.signInWithCredential(credential)).user;

    return firebaseUser;
  }

  Widget sociallogin() {
    if (Platform.isAndroid) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () async {
              ArsProgressDialog progressDialog = ArsProgressDialog(context,
                  blur: 2,
                  backgroundColor: Color(0x33000000),
                  animationDuration: Duration(milliseconds: 500));

              progressDialog.show();
              try {
                var user = await handleSignIn().then((_) {
                  print(_.toString());
                  progressDialog.dismiss();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );

                  return;
                });
              } catch (e) {
                progressDialog.dismiss();
                showInSnackBar("Error");
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: _width * 0.07,
              backgroundImage: AssetImage("assets/images/google.png"),
            ),
          ),
          InkWell(
            onTap: () async {
              ArsProgressDialog progressDialog = ArsProgressDialog(context,
                  blur: 2,
                  backgroundColor: Color(0x33000000),
                  animationDuration: Duration(milliseconds: 500));

              progressDialog.show();
              try {
                // by default the login method has the next permissions ['email','public_profile']
                AccessToken accessToken = await FacebookAuth.instance.login();
                print(accessToken.toJson());
                // get the user data
                final userData = await FacebookAuth.instance.getUserData();
                print(userData);
                progressDialog.dismiss();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } catch (e) {
                print(e.message.toString());
                progressDialog.dismiss();
              }
            },
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: _width * 0.07,
              backgroundImage: AssetImage("assets/images/facebook.png"),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  AuthRepository _authRepository = AuthRepository();

  Widget txtfield(
      {String txt,
      String labelTxt,
      TextEditingController controller,
      TextInputType inputType}) {
    return Padding(
      padding:
          EdgeInsets.only(left: _width * 0.09, right: _width * 0.09, top: 0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: labelTxt,
          hintText: "$txt",
          hintStyle:
              TextStyle(fontSize: _width * 0.035, color: Color(0xffA7A7A7)),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
  }

  Future<void> signIn() async {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        backgroundColor: Color(0x33000000),
        animationDuration: Duration(milliseconds: 500));

    progressDialog.show();
    try {
      dynamic result = await _authRepository.signInWithEmailAndPassword(
          emailController.text, passController.text);

      if (result != null) {
        //    this.progressDialog.dismiss();
        print('Sucessfully logged in');
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }), (route) => false);
      } else {
        // this.progressDialog.dismiss();
        showInSnackBar('please supply valid email.');
        print('please supply valid email.');
      }
    } catch (e) {
      progressDialog.dismiss();
      showInSnackBar("User not found");
      // showAlertDialog(
      //   context,
      //   'Please use correct credentials',
      //   'User not found',
      // );
      // this.progressDialog.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              body: SizedBox(
                height: _height - keyboardHeight,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/background.png",
                            fit: BoxFit.fill,
                            color: CustomColors.primaryColor,
                            width: _width,
                            height: _height,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: _height * 0.05, left: _height * 0.05),
                            child: Text(
                              "Welcome \nBack",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: _width * 0.12),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: _height / 3,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0),
                                    )),
                                width: _width,
                                height: _height / 1.5,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: _height * 0.05),
                                      child: Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              signIn();
                                            },
                                            child: Text(
                                              "Sign in",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: _width * 0.08),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    txtfield(
                                      txt: "Example@xyz.com",
                                      labelTxt: 'Email',
                                      controller: emailController,
                                      inputType: TextInputType.emailAddress,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: _width * 0.09,
                                        right: _width * 0.09,
                                      ),
                                      child: TextField(
                                        onSubmitted: (v) {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          if (emailController.text.isEmpty) {
                                            showInSnackBar(
                                                "Email field should not be empty");
                                            return;
                                          }

                                          if (passController.text.isEmpty) {
                                            showInSnackBar(
                                                "Password field should not be empty");
                                            return;
                                          }
                                          signIn();
                                        },
                                        controller: passController,
                                        obscureText: _passHidden,
                                        decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _passHidden = !_passHidden;
                                              });
                                            },
                                            child: Icon(
                                              _passHidden
                                                  ? Icons.visibility_rounded
                                                  : Icons
                                                      .visibility_off_rounded,
                                            ),
                                          ),
                                          labelText: 'Password',
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              fontSize: _width * 0.035,
                                              color: Color(0xffA7A7A7)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: _width * 0.09,
                                        right: _width * 0.09,
                                      ),
                                      child: Text(
                                        "Or login using your social media account",
                                        style:
                                            TextStyle(color: Color(0xFFAA9797)),
                                      ),
                                    ),
                                    sociallogin(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: _width * 0.09,
                                        right: _width * 0.09,
                                      ),
                                      child: Text(
                                        "Don't have account join now",
                                        style:
                                            TextStyle(color: Color(0xff5F5F5F)),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: _width * 0.09,
                                            right: _width * 0.09,
                                            top: _height * 0.00),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUp()),
                                                );
                                              },
                                              child: Text(
                                                "Sign up",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: _width * 0.04,
                                                    color: Color(0xFF505050)),
                                              ),
                                            )
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: _height / 3.4,
                            left: _width / 1.4,
                            child: FloatingActionButton(
                                backgroundColor: CustomColors.primaryColor,
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: _width * 0.08,
                                ),
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  if (emailController.text.isEmpty) {
                                    showInSnackBar(
                                        "Email field should not be empty");
                                    return;
                                  }

                                  if (passController.text.isEmpty) {
                                    showInSnackBar(
                                        "Password field should not be empty");
                                    return;
                                  }
                                  signIn();
                                }),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
