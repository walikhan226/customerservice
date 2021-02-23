import 'package:customerservice/localization/keys.dart';
import 'package:customerservice/screens/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter_translate/global.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  Icon(
                    Icons.menu_rounded,
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
                  width: 60,
                  height: 80,
                ),
              ),
              Container(
                width: width * 0.5,
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Text(
            translate(Keys.View),
            style: TextStyle(
              fontSize: 16,
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
