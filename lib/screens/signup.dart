import 'package:customerservice/constants/custom_colors.dart';
import 'package:customerservice/repositories/auth_repositories.dart';
import 'package:customerservice/screens/login.dart';
import 'package:customerservice/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double _width, _height;
  bool _isLoading = false;
  bool _passHidden = true;
  AuthRepository _authRepository = AuthRepository();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget txtfield(
      {String txt,
      String labelTxt,
      TextEditingController controller,
      TextInputType inputType}) {
    return Padding(
      padding: EdgeInsets.only(
          left: _width * 0.09, right: _width * 0.09, top: _height * 0.02),
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

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      dynamic result = await _authRepository.signUpWithEmailAndPassword(
          emailController.text, passController.text);
      if (result != null) {
        print('Sucessfully registered');
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }), (route) => false);
      }
    } catch (e) {
      print(e);
      showInSnackBar(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox(
              height: _height - keyboardHeight,
              child: SingleChildScrollView(
                child: Column(
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
                              top: _height * 0.08, left: _height * 0.05),
                          child: Text(
                            "Lets Start",
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
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    topRight: Radius.circular(40.0),
                                  )),
                              width: _width,
                              height: _height / 1.5,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: _height * 0.02,
                                        left: _height * 0.05),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Sign Up",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: _width * 0.08),
                                        ),
                                      ],
                                    ),
                                  ),
                                  txtfield(
                                      txt: "Full Name",
                                      labelTxt: 'Name',
                                      controller: nameController),
                                  txtfield(
                                      txt: "+92300 0000000",
                                      labelTxt: 'Number',
                                      controller: numberController,
                                      inputType: TextInputType.number),
                                  txtfield(
                                      txt: "Example@xyz.com",
                                      labelTxt: 'Email',
                                      controller: emailController,
                                      inputType: TextInputType.emailAddress),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: _width * 0.09,
                                        right: _width * 0.09,
                                        top: _height * 0.01),
                                    child: TextField(
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
                                                : Icons.visibility_off_rounded,
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
                                  SizedBox(
                                    height: _height * 0.035,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: _width * 0.09,
                                          right: _width * 0.09,
                                          top: _height * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Already have an account?",
                                            style: TextStyle(
                                                color: Color(0xffFF6A6A)),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Login(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Sign in",
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
                              String pattern1 = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                              Pattern pattern2 =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regex1 = new RegExp(pattern1);
                              RegExp regex2 = new RegExp(pattern2);
                              if (emailController.text.length < 1 ||
                                  passController.text.length == 0) {
                                showInSnackBar("Fields can't be empty");
                              } else if (nameController.text.length < 2) {
                                showInSnackBar("Please provide correct name");
                              } else if (!regex1
                                      .hasMatch(numberController.text) ||
                                  numberController.text.length != 13) {
                                showInSnackBar(
                                    "Please enter valid mobile number");
                              } else if (passController.text.length < 6) {
                                showInSnackBar(
                                    "Password length can't be less than 6");
                              } else if (!regex2
                                  .hasMatch(emailController.text)) {
                                showInSnackBar("Please enter valid email");
                              } else {
                                _signUp();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
