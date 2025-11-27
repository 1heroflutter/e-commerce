import 'package:e_commerce_app/common/widgets/loaders/loaders.dart';
import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/utils/constants/app_animations.dart';
import 'package:e_commerce_app/utils/network/network_manager.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../data/repositories/user/usermodel.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final username = TextEditingController();
  final lastname = TextEditingController();
  final firstname = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> signup() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'We are processing your information', AppAnimations.loading_blue);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (!signupFormKey.currentState!.validate()) return;

      if (!privacyPolicy.value) {
        Loaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());
      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstname.text.trim(),
        lastName: lastname.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phone.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

// Show Success Message
      Loaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');

// Move to Verify Email Screen
      Get.to(() =>  VerifyEmailScreen(email: email.text.trim(),));

    } catch (e) {
      Loaders.errorSnackbar(title: 'Oh Snap!', message: e.toString());
    } finally {
      FullScreenLoader.stopLoading();
    }
  }
}
