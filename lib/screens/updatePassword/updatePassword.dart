import 'package:customerservice/constants/custom_colors.dart';
import 'package:customerservice/localization/keys.dart';
import 'package:customerservice/screens/updatePassword/updateController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:get/get.dart';

class UpdatePassword extends StatelessWidget {
  final _controller = Get.put(UpdateController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        title: Text(translate(Keys.updatePassword)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Card(
                elevation: 4,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      alignment: Alignment.center,
                      child: Text(
                        translate(Keys.updatePasswordDesc),
                        style: TextStyle(
                          color: Colors.blueGrey,
                          //fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    /* ListTile(
                      title: passwordField(
                        txt: "",
                        labelTxt: 'Old Password',
                        controller: _controller.oldPassword,
                        inputType: TextInputType.text,
                      ),
                    ),*/
                    ListTile(
                      title: passwordField(
                        txt: "",
                        labelTxt: translate(Keys.newPass),
                        controller: _controller.newPassword,
                        inputType: TextInputType.text,
                      ),
                    ),
                    ListTile(
                      title: passwordField(
                        txt: "",
                        labelTxt: translate(Keys.cPass),
                        controller: _controller.confirmPassword,
                        inputType: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      child: Obx(() => RaisedButton(
                            color: _controller.showLoader.value
                                ? Colors.blueGrey
                                : CustomColors.primaryColor,
                            onPressed: () {
                              if (_controller.showLoader.value) {
                                return;
                              }

                              _controller.updatePassword();
                            },
                            child: Text(
                              translate(Keys.submit),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordField(
      {String txt,
      String labelTxt,
      TextEditingController controller,
      TextInputType inputType}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: labelTxt,
          hintText: "$txt",
          hintStyle:
              TextStyle(fontSize: Get.width * 0.035, color: Color(0xffA7A7A7)),
        ),
        obscureText: true,
      ),
    );
  }
}
