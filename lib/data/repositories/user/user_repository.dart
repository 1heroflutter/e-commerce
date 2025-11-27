
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widgets/exceptions/firebase_exception.dart';
import 'package:e_commerce_app/common/widgets/exceptions/format_exception.dart';
import 'package:e_commerce_app/common/widgets/exceptions/platform_exception.dart';
import 'package:e_commerce_app/data/repositories/authentication/authentication_repository.dart';
import 'package:e_commerce_app/data/repositories/user/usermodel.dart';
import 'package:e_commerce_app/data/services/cloudinary_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to save user data to Firestore.
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw BasicFirebaseException( code: e.code,).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to get user data from firestore.
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot= await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw BasicFirebaseException( code: e.code,).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to update user data from firestore.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    try {
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
    } on FirebaseException catch (e) {
      throw BasicFirebaseException( code: e.code,).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Function to update any field in Users collection.
  Future<void> updateSingleField(Map<String, dynamic>json) async {
    try {
       await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);

    } on FirebaseException catch (e) {
      throw BasicFirebaseException( code: e.code,).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /// remove user from firestore
  Future<void> removeUser(String userUid) async {
    try {
      await _db.collection("Users").doc(userUid).delete();

    } on FirebaseException catch (e) {
      throw BasicFirebaseException( code: e.code,).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  /// Upload any Image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final url = await CloudinaryService().uploadImageFile(image, folder: path);
      return url;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:  e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code: e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}