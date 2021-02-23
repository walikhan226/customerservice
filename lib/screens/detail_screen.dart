import 'package:customerservice/localization/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final String title;

  const DetailScreen({Key key, @required this.title}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController name = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController location = new TextEditingController();

  String url() {
    var phone = "+97124412297";
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
      to: ['customers@eitmamdom.ae'],
      cc: [''],
      subject: 'Sample',
      body: message,
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF000a32),
        title: Text(
          translate(Keys.Contact_Us),
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: translate(Keys.Name),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 4.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: mobile,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: translate(Keys.Phone_Number),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 4.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildContactTile(
                          txt: 'WhatsApp',
                          image: 'assets/images/whatsapp.png',
                          height: screenHeight * 0.12,
                          width: screenWidth * 0.25,
                          onPressed: () async {
                            String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regex1 = new RegExp(pattern);
                            if (name.text.length < 2 ||
                                mobile.text.length == 0) {
                              showInSnackBar("Fields can't be empty");
                            } else if (!regex1.hasMatch(mobile.text) ||
                                mobile.text.length < 10) {
                              showInSnackBar(
                                  "Please enter valid mobile number");
                            } else {
                              if (await canLaunch(url())) {
                                await launch(url());
                              } else {
                                throw 'Could not launch ${url()}';
                              }
                            }
                          }),
                      buildContactTile(
                        txt: 'Email',
                        image: 'assets/images/mail.png',
                        height: screenHeight * 0.12,
                        width: screenWidth * 0.25,
                        onPressed: () {
                          String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                          RegExp regex1 = new RegExp(pattern);
                          if (name.text.length < 2 || mobile.text.length == 0) {
                            showInSnackBar("Fields can't be empty");
                          } else if (!regex1.hasMatch(mobile.text) ||
                              mobile.text.length < 10) {
                            showInSnackBar("Please enter valid mobile number");
                          } else {
                            launchMailto();
                          }
                        },
                      ),
                      buildContactTile(
                          txt: 'Call',
                          image: 'assets/images/phone.png',
                          height: screenHeight * 0.12,
                          width: screenWidth * 0.25,
                          onPressed: () async {
                            final url = "tel:+97124412297";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                translate(Keys.Company_Name),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContactTile(
      {String txt,
      double height,
      double width,
      String image,
      VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            txt,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Container(
            height: height,
            width: width,
            margin: EdgeInsets.only(
              right: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Colors.blue),
            ),
            child: Image.asset(
              image,
              scale: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
