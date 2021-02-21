import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:mailto/mailto.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController location = new TextEditingController();

  String url() {
    var phone = "+923158733304";
    String message = 'Name: ' +
        name.text +
        '\n' +
        'Mobile Number: ' +
        mobile.text +
        '\n' +
        'Location: ' +
        location.text;
    // add the [https]
    return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
  }

  launchMailto() async {
    String message = 'Name: ' +
        name.text +
        '\n' +
        'Mobile Number: ' +
        mobile.text +
        '\n' +
        'Location: ' +
        location.text;
    final mailtoLink = Mailto(
      to: ['remerse2020@gmail.com'],
      cc: [''],
      subject: 'Sample',
      body: message,
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFieldPlus(
            controller: name,
            margin: EdgeInsets.only(top: 24),
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 60,
            backgroundColor: Colors.black12,
            cursorColor: Colors.red,
            textInputType: TextInputType.name,
            placeholder: TextPlus(
              'Name',
              color: Colors.black38,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFieldPlus(
            controller: mobile,
            margin: EdgeInsets.only(top: 24),
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 60,
            backgroundColor: Colors.black12,
            cursorColor: Colors.red,
            textInputType: TextInputType.number,
            placeholder: TextPlus(
              'mobile number',
              color: Colors.black38,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFieldPlus(
            controller: location,
            margin: EdgeInsets.only(top: 24),
            padding: EdgeInsets.symmetric(horizontal: 8),
            height: 60,
            backgroundColor: Colors.black12,
            cursorColor: Colors.red,
            textInputType: TextInputType.streetAddress,
            placeholder: TextPlus(
              'location',
              color: Colors.black38,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        RaisedButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black)),
          onPressed: () async {
            if (await canLaunch(url())) {
              await launch(url());
            } else {
              throw 'Could not launch ${url()}';
            }
          },
          child: Text("Open WhatsApp"),
        ),
        SizedBox(
          height: 30,
        ),
        RaisedButton(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.black)),
          onPressed: () {
            launchMailto();
          },
          child: Text("Open Email"),
        )
      ],
    );
  }
}
