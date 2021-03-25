import 'package:customerservice/constants/custom_colors.dart';
import 'package:customerservice/screens/home_screen.dart';
import 'package:customerservice/screens/login.dart';
import 'package:flutter/material.dart';

class Getstarted extends StatelessWidget {
  double font8,
      font10,
      font12,
      font14,
      font15,
      font,
      font16,
      font17,
      font20,
      font50;

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;

    font8 = _width * 0.019;
    font10 = _width * 0.0244;

    font12 = _width * 0.029;
    font14 = _width * 0.034;
    font15 = _width * 0.037;
    font16 = _width * 0.039;
    font17 = _width * 0.041;
    font20 = _width * 0.046;
    font50 = _width * 0.115;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Image.asset(
                "assets/images/logo2.PNG",
                fit: BoxFit.fill,
                width: _width * 0.5,
                height: _height * 0.13,
              ),
            ),
          ),
          SizedBox(
            height: _width * 0.2,
          ),
          Column(
            children: [
              Container(
                width: _width / 1.6,
                height: _height * 0.08,
                child: RaisedButton(
                  color: CustomColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      width: 2,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  child: Text(
                    "LOGIN OR REGISTER",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: font20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: _width / 1.6,
                height: _height * 0.08,
                child: RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      width: 2,
                      color: CustomColors.primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          loggedin: false,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "SKIP FOR NOW",
                    style: TextStyle(
                        color: CustomColors.primaryColor,
                        fontSize: font20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
