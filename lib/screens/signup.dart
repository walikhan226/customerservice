import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                        txtfield("Full Name"),
                        txtfield("Phone Number"),
                        txtfield("Email"),
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
                        SizedBox(
                          height: _height * 0.035,
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
                                  "Already have and account?",
                                  style: TextStyle(color: Color(0xffFF6A6A)),
                                ),
                                GestureDetector(
                                  onTap: () {},
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
                top: _height / 3.1,
                left: _width / 1.4,
                child: FloatingActionButton(

                    //  backgroundColor: Color(0xffB93AfC),
                    backgroundColor: Color(0xFF0072e1),
                    child: Icon(
                      Icons.arrow_forward,
                      size: _width * 0.08,
                    ),
                    onPressed: () {}),
              )
            ],
          ),
        ],
      ),
    );
  }
}
