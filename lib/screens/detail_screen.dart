import '../localization/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
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
  TextEditingController email = new TextEditingController();

  @override
  void initState() {
    super.initState();
    getcurrentlocation();
  }

  String place = "";
  Future<void> getcurrentlocation() async {
    try {
      var data = await _determinePosition();
      print(data.latitude);
      print(data.longitude);
      final coordinates = new Coordinates(data.latitude, data.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print(
          ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
      this.place = first.addressLine;

      print(this.place);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  String url() {
    var phone = "+97124412297";
    String message = 'Name: ' +
        name.text +
        '\n' +
        'Mobile Number: ' +
        mobile.text +
        '\n' +
        'Service name: ' +
        widget.title +
        '\n' +
        "Email: " +
        email.text +
        "\n" +
        "Location: " +
        this.place;

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
        "Email: " +
        email.text +
        "\n" +
        "Location: " +
        this.place;
        
    final mailtoLink = Mailto(
      to: ['customers@eitmamdom.ae'],
      cc: [''],
      subject: widget.title,
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

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
          padding: EdgeInsets.only(
              left: screenWidth * 0.05, top: 20, right: screenWidth * 0.05),
          child: SingleChildScrollView(
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
                  height: 25,
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
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: translate(Keys.Email),
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
                  height: screenHeight * 0.05,
                ),
                Column(
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        buildContactTile(
                            txt: 'WhatsApp',
                            image: 'assets/images/whatsapp.png',
                            height: screenHeight * 0.12,
                            width: screenWidth * 0.25,
                            onPressed: () async {
                              if (name.text.isEmpty) {
                                showInSnackBar(translate(
                                  Keys.Name_error,
                                ));
                                return;
                              }
                              if (mobile.text.isEmpty) {
                                showInSnackBar(translate(Keys.Phone_error));
                                return;
                              }

                              if (email.text.isEmpty) {
                                showInSnackBar("Email field is empty");
                                return;
                              }
                              if (!isEmail(email.text)) {
                                showInSnackBar("Invalid email");
                                return;
                              }
                              if (await canLaunch(url())) {
                                await launch(url());
                              } else {
                                showInSnackBar("Error");
                              }
                            }),
                        buildContactTile(
                          txt: 'Email',
                          image: 'assets/images/mail.png',
                          height: screenHeight * 0.12,
                          width: screenWidth * 0.25,
                          onPressed: () async {
                            if (name.text.isEmpty) {
                              showInSnackBar(translate(Keys.Name_error));
                              return;
                            }
                            if (mobile.text.isEmpty) {
                              showInSnackBar(translate(Keys.Phone_error));
                              return;
                            }
                            if (email.text.isEmpty) {
                              showInSnackBar("Email field is empty");
                              return;
                            }
                            if (!isEmail(email.text)) {
                              showInSnackBar("Invalid email");
                              return;
                            }
                            if (await canLaunch(url())) {
                              await launch(url());
                            } else {
                              showInSnackBar("Error");
                            }
                            launchMailto();
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
                                showInSnackBar("Error");
                              }
                            }),
                        buildContactTile(
                            txt: 'Instagram',
                            image: 'assets/images/insta.png',
                            height: screenHeight * 0.12,
                            width: screenWidth * 0.25,
                            onPressed: () async {
                              var url =
                                  'https://www.instagram.com/domestic.ae/';

                              if (await canLaunch(url)) {
                                await launch(
                                  url,
                                  universalLinksOnly: true,
                                );
                              } else {
                                throw 'There was a problem to open the url: $url';
                              }
                            }),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  translate(Keys.Company_Name),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: screenWidth * 0.043,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
