import 'package:customerservice/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double _width, _height;

  Widget txtfield(String txt) {
    return Padding(
      padding: EdgeInsets.only(
          left: _width * 0.09, right: _width * 0.09, top: _height * 0.04),
      child: TextField(
        decoration: InputDecoration(
          hintText: "$txt",
          hintStyle:
              TextStyle(fontSize: _width * 0.035, color: Color(0xffA7A7A7)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffb93afc),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset(
                "assets/images/background.png",
                fit: BoxFit.fill,
                color: Color(0xFF0072e1),
                width: _width,
                height: _height,
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: _height * 0.05, left: _height * 0.05),
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
                    height: _height / 2.7,
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
                              top: _height * 0.05, left: _height * 0.05),
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
                        txtfield("Username"),
                        Padding(
                          padding: EdgeInsets.only(
                              left: _width * 0.09,
                              right: _width * 0.09,
                              top: _height * 0.04),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.remove_red_eye),
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
                            style: TextStyle(color: Color(0xffA7A7A7)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: _width * 0.07,
                              backgroundImage:
                                  AssetImage("assets/images/google.png"),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: _width * 0.09,
                              backgroundImage:
                                  AssetImage("assets/images/facebook.png"),
                            ),
                            // CircleAvatar(
                            //   backgroundColor: Colors.transparent,
                            //   radius: _width * 0.07,
                            //   backgroundImage:
                            //       AssetImage("assets/images/apple.png"),
                            // ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: _width * 0.09,
                              right: _width * 0.09,
                              top: _height * 0.01),
                          child: Text(
                            "By continuing you agree to Terms & Conditions",
                            style: TextStyle(color: Color(0xff5F5F5F)),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: _width * 0.09,
                                right: _width * 0.09,
                                top: _height * 0.04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Forgot password?",
                                  style: TextStyle(color: Color(0xffFF6A6A)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUp()),
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
                top: _height / 3.1,
                left: _width / 1.4,
                child: FloatingActionButton(

                    //  backgroundColor: Color(0xffB93AfC),
                    backgroundColor: Color(0xFF0072e1),
                    child: Icon(
                      Icons.arrow_forward,
                      size: _width * 0.08,
                    ),
                    onPressed: () {
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
    );
  }
}
