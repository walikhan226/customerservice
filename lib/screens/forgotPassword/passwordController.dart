import 'package:customerservice/localization/keys.dart';
import 'package:customerservice/repositories/auth_repositories.dart';
import 'package:customerservice/repositories/db_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  var showLoader = false.obs;
  var _repo = AuthRepository();

  void forgotPasswordLogic() {
    if (emailController.text.isEmpty) {
      Get.snackbar(translate(Keys.alert), translate(Keys.enterEmail));
      return;
    }
    showLoader.value = true;
    _repo.forgotPassword(emailController.text);
    Future.delayed(Duration(seconds: 3), () {
      showLoader.value = false;
    });
  }
}
