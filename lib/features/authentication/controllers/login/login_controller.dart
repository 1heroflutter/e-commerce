import 'package:e_commerce_app/common/widgets/loaders/loaders.dart';
import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/data/repositories/user/user_controller.dart';
import 'package:e_commerce_app/utils/constants/app_animations.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../navigation_menu.dart';
import '../../../../utils/network/network_manager.dart';
import '../../screens/signup/verify_email.dart';

class LoginController extends GetxController {
  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController= UserController();


  @override
  void onInit() {
    email.text = localStorage.read("REMEMBER_ME_EMAIL");
    password.text = localStorage.read("REMEMBER_ME_PASSWORD");
    super.onInit();
  } // --- Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
        'Logging you in...',
        AppAnimations.loading_blue,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        await localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        await localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      final userCredentials = await AuthenticationRepository.instance.signInWithEmailAndPassword(email.text, password.text);

      FullScreenLoader.stopLoading();

      final user = userCredentials.user;
      if (user != null) {
        if (user.emailVerified) {
          Get.offAll(() => NavigationMenu());
        } else {
          Get.offAll(() => VerifyEmailScreen(email: user.email));
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      print("Login error: $e");
    }
  }
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog('Logging you in...', AppAnimations.loading_blue);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();
      await userController.saveUserRecord(userCredentials);
      FullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      Loaders.errorSnackbar(title: 'Oh Snap', message: e.toString());
    }
  }
}
