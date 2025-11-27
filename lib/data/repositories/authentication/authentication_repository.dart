import 'package:e_commerce_app/common/widgets/exceptions/firebase_auth_exception.dart';
import 'package:e_commerce_app/common/widgets/exceptions/firebase_exception.dart';
import 'package:e_commerce_app/common/widgets/exceptions/format_exception.dart';
import 'package:e_commerce_app/common/widgets/exceptions/platform_exception.dart';
import 'package:e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:e_commerce_app/features/authentication/screens/login/login.dart';
import 'package:e_commerce_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commerce_app/features/authentication/screens/signup/verify_email.dart';
import 'package:e_commerce_app/navigation_menu.dart';
import 'package:e_commerce_app/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///var
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    var user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        await LocalStorage.init(user.uid);
        Get.offAll(() => NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email,));
      }
    }else{
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnboardingScreen());
    }
  }
  /// [GoogleAuthentication] - LOGIN WITH GOOGLE
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount =await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;
      final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken,idToken: googleAuth?.idToken);
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw BasicFirebaseAuthException(code: e.message!).message;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /// [EmailAuthentication] - LOGIN
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw BasicFirebaseAuthException(code: e.message!).message;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw BasicFirebaseAuthException(code: e.message!).message;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /// [EmailVerification] - FORGET PASSWORD
  Future<void> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw BasicFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code: e.code).message;
    } on FormatException {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /// [EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw BasicFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code: e.code).message;
    } on FormatException {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /// [ReAuth] - RE AUTHENTICATION USER
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      AuthCredential authCredential =EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      throw BasicFirebaseAuthException(code: e.code).message;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code: e.code).message;
    } on FormatException {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /// [LogoutUser] - Valid for any authentication.
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw BasicFirebaseAuthException(code:e.code).message;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:e.code).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /// [DeleteUser] - Remove user Auth & FireStore Acc.
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUser(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
      await GoogleSignIn().signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw BasicFirebaseAuthException(code:e.code).message;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:e.code).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
