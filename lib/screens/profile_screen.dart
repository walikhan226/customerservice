import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerservice/localization/keys.dart';
import 'package:customerservice/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isProfileUpdating = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF000a32),
        title: Text(
          translate(Keys.Profile),
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: isProfileUpdating == false
          ? FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData && snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                print(snapshot.data.data());
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CircleAvatar(
                        //   backgroundImage:snapshot.data.data()['imageUrl'] AssetImage('assets/images/profile.jpeg'),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      translate(Keys.Email),
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.025,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.015,
                                    ),
                                    Text(
                                      translate(Keys.Name),
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.025,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.015,
                                    ),
                                    Text(
                                      translate(Keys.Phone_Number),
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.025,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxWidth: 220),
                                  child: Text(
                                    snapshot.data.data()['email'] ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: screenHeight * 0.025,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.015,
                                ),
                                Text(
                                  snapshot.data.data()['username'] ?? '',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.025,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.015,
                                ),
                                Text(
                                  snapshot.data.data()['number'] ?? '',
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.025,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.015,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.1),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isProfileUpdating = true;
                              emailController.text =
                                  snapshot.data.data()['email'] ?? '';
                              nameController.text =
                                  snapshot.data.data()['username'] ?? '';
                              numberController.text =
                                  snapshot.data.data()['number'] ?? '';
                            });
                          },
                          child: Container(
                            height: screenHeight * 0.07,
                            width: screenWidth * 0.8,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFF000a32),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              translate(Keys.Update),
                              style: TextStyle(
                                fontSize: screenHeight * 0.025,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
          : Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  top: screenHeight * 0.2,
                  right: screenWidth * 0.05),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
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
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
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
                    controller: numberController,
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
                  SizedBox(height: screenHeight * 0.1),
                  GestureDetector(
                    onTap: () {
                      UserModel user = UserModel(
                        email: emailController.text,
                        username: nameController.text,
                        number: numberController.text,
                      );
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .update(UserModel().toMap(user));
                      setState(() {
                        isProfileUpdating = false;
                      });
                    },
                    child: Container(
                      height: screenHeight * 0.07,
                      width: screenWidth * 0.8,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFF000a32),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        translate(Keys.Done),
                        style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
