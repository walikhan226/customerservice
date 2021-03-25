import 'package:customerservice/localization/keys.dart';
import 'package:customerservice/repositories/auth_repositories.dart';
import 'package:customerservice/screens/detail_screen.dart';
import 'package:customerservice/screens/getstarted.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter_translate/global.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

class HomeScreen extends StatefulWidget {
  bool loggedin;
  HomeScreen({@required this.loggedin});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final box = GetStorage();
  Widget myPopMenu() {
    return PopupMenuButton(
        color: Colors.white,
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onSelected: (value) async {
          await AuthRepository().signOut().then((_) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Getstarted()),
                (Route<dynamic> route) => false);
          });
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: <Widget>[Text('LOGOUT')],
                  )),
            ]);
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _drawerKey,
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: Color(0xFF000a32),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 10, left: 10, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.loggedin
                      ? IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _drawerKey.currentState.openDrawer();
                          },
                        )
                      : BackButton(
                          color: Colors.white,
                        ),
                  FlutterToggleTab(
                    width: 50,
                    borderRadius: 30,
                    height: 40,
                    initialIndex: 0,
                    selectedBackgroundColors: [const Color(0xFF0A3157)],
                    selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    unSelectedTextStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    isScroll: false,
                    labels: ["English", "Arabic"],
                    selectedLabelIndex: (index) {
                      index == 0
                          ? changeLocale(context, 'en_US')
                          : changeLocale(context, 'ar');
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 15),
                  children: [
                    listTile(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.8,
                      context: context,
                      title: translate(Keys.List1_Title),
                      image: 'assets/images/1.jpeg',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailScreen(
                            title: translate(Keys.List1_Title),
                          );
                        }));
                      },
                    ),
                    listTile(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.8,
                      context: context,
                      title: translate(Keys.List2_Title),
                      image: 'assets/images/2.jpeg',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailScreen(
                            title: translate(Keys.List2_Title),
                          );
                        }));
                      },
                    ),
                    listTile(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.8,
                      context: context,
                      title: translate(Keys.List3_Title),
                      image: 'assets/images/3.jpeg',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailScreen(
                            title: translate(Keys.List3_Title),
                          );
                        }));
                      },
                    ),
                    listTile(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.8,
                      context: context,
                      title: translate(Keys.List4_Title),
                      image: 'assets/images/4.jpeg',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailScreen(
                            title: translate(Keys.List4_Title),
                          );
                        }));
                      },
                    ),
                    listTile(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.8,
                      context: context,
                      title: translate(Keys.List5_Title),
                      image: 'assets/images/5.jpeg',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailScreen(
                            title: translate(Keys.List5_Title),
                          );
                        }));
                      },
                    ),
                    listTile(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.8,
                      context: context,
                      title: translate(Keys.List6_Title),
                      image: 'assets/images/6.jpeg',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailScreen(
                            title: translate(Keys.List5_Title),
                          );
                        }));
                      },
                    ),
                    listTile(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.8,
                      context: context,
                      title: translate(Keys.List7_Title),
                      image: 'assets/images/6.jpeg',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailScreen(
                            title: translate(Keys.List7_Title),
                          );
                        }));
                      },
                    ),
                    listTile(
                      height: screenHeight * 0.15,
                      width: screenWidth * 0.8,
                      context: context,
                      title: translate(Keys.List8_Title),
                      image: 'assets/images/8.jpeg',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailScreen(
                            title: translate(Keys.List8_Title),
                          );
                        }));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(Icons.arrow_back_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Getstarted()),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Signed in as ",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )),
              Center(
                  child: Text(
                box.read("email") ?? '',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Log Out"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Getstarted()),
                  );
                  box.erase();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget listTile(
    {double height,
    double width,
    BuildContext context,
    String title,
    String image,
    VoidCallback onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF000a32),
          width: 4,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border:
                      Border.all(width: 8, color: Colors.grey.withOpacity(0.2)),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                  width: width * 0.2,
                  height: height * 0.6,
                ),
              ),
              Container(
                width: width * 0.5,
                margin:
                    EdgeInsets.only(left: width * 0.02, right: width * 0.03),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: width * 0.055,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            translate(Keys.View),
            style: TextStyle(
              fontSize: width * 0.050,
              fontWeight: FontWeight.w600,
              color: Color(0xFF000a32),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF000a32),
          )
        ],
      ),
    ),
  );
}
