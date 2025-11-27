import 'package:e_commerce_app/common/widgets/loaders/loaders.dart';
import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:e_commerce_app/utils/network/network_manager.dart';
import 'package:e_commerce_app/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/app_animations.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final authenticationRepository = AuthenticationRepository();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();


  Future<void> sendPasswordResetEmail(String email)async {
    try{
      FullScreenLoader.openLoadingDialog('We are processing your information', AppAnimations.loading_blue);
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }
      if(!forgetPasswordFormKey.currentState!.validate())return;
      await authenticationRepository.forgetPassword(email);
      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(title: "Email Sent", message: "Email Link Sent to Reset your Password".tr);
      Get.to(()=> ResetPasswordScreen(email: email));
    }catch (e){
      FullScreenLoader.stopLoading();
      Loaders.errorSnackbar(title: "Oh Snap", message: e.toString());
    }
  }
  Future<void> reSendPasswordRestEmail(String email)async {
    try{
      FullScreenLoader.openLoadingDialog('We are processing your information', AppAnimations.loading_blue);
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FullScreenLoader.stopLoading();
        return;
      }
      await authenticationRepository.forgetPassword(email);
      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(title: "Email Sent", message: "Email Link Sent to Reset your Password".tr);
    }catch (e){
      FullScreenLoader.stopLoading();
      Loaders.errorSnackbar(title: "Oh Snap", message: e.toString());
    }
  }
}
