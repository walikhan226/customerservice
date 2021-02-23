import 'package:customerservice/constants/custom_colors.dart';
import 'package:customerservice/repositories/auth_repositories.dart';
import 'package:customerservice/screens/home_screen.dart';
import 'package:customerservice/screens/signup.dart';
import 'package:customerservice/widgets/alert_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  AuthRepository _authRepository = AuthRepository();

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

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      dynamic result = await _authRepository.signInWithEmailAndPassword(
          emailController.text, passController.text);

      if (result != null) {
        print('Sucessfully logged in');
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }), (route) => false);
      } else {
        showInSnackBar('please supply valid email.');
        print('please supply valid email.');
      }
    } catch (e) {
      print(e);
      showAlertDialog(
        context,
        'Please use correct credentials',
        'User not found',
      );
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
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
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
                                    padding: EdgeInsets.only(
                                        top: _height * 0.01,
                                        left: _height * 0.05),
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {},
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
                                        top: _height * 0.04),
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
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: _width * 0.09,
                                        right: _width * 0.09,
                                        top: _height * 0.04),
                                    child: Text(
                                      "Or login using your social media account",
                                      style:
                                          TextStyle(color: Color(0xffA7A7A7)),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () async {
                                          // await _authRepository.signInWithGoogle();
                                          // Navigator.push(context,
                                          //     MaterialPageRoute(builder: (context) {
                                          //   return HomeScreen();
                                          // }));
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          radius: _width * 0.07,
                                          backgroundImage: AssetImage(
                                              "assets/images/google.png"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: _width * 0.09,
                                        right: _width * 0.09,
                                        top: _height * 0.01),
                                    child: Text(
                                      "By continuing you agree to Terms & Conditions",
                                      style:
                                          TextStyle(color: Color(0xff5F5F5F)),
                                    ),
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
                                            "Forgot password?",
                                            style: TextStyle(
                                                color: Color(0xffFF6A6A)),
                                          ),
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
                                  SizedBox(
                                    height: _height * 0.045,
                                  ),
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
                                Pattern pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regex = new RegExp(pattern);
                                if (emailController.text.length < 1 ||
                                    passController.text.length == 0) {
                                  showInSnackBar("Fields can't be empty");
                                } else if (!regex
                                    .hasMatch(emailController.text)) {
                                  showInSnackBar("Please enter valid email");
                                } else if (passController.text.length < 6) {
                                  showInSnackBar(
                                      "Password length can't be less than 6");
                                } else {
                                  _signIn();
                                }

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => Searchlocation1()),
                                // );
                              }),
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
