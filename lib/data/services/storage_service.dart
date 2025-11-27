import 'dart:io';
import 'package:e_commerce_app/common/widgets/exceptions/platform_exception.dart';
import 'package:e_commerce_app/data/services/cloudinary_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StorageService extends GetxController{
  static StorageService get instance => Get.find();
  final _cloudinary = CloudinaryService();
  /// Returns a Uint8List containing image data.
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      // Handle exceptions gracefully
      throw 'Error loading image data: $e';
    }
  }

  /// Upload Image on Cloudinary
  /// Returns the URL of the uploaded image.
  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      final url = _cloudinary.uploadImageFile(image, folder: path);
      return url;
    } catch (e) {
      // Handle exceptions gracefully
      if (e is FirebaseException) {
        throw 'Firebase Exception: ${e.message}';
      } else if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is BasicPlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something Went Wrong! Please try again.';
      }
    }
  }

  /// Upload Uint8List to Cloudinary
  Future<String> uploadImageData(String path, Uint8List image, String name) async {
    try {
      final url = await _cloudinary.uploadImageBytes(image, folder: path, publicId: name);
      return url;
    } catch (e) {
      // Bỏ FirebaseException, bắt lỗi chung
      if (e is SocketException) {
        throw 'Network Error: ${e.message}';
      } else if (e is PlatformException) {
        throw 'Platform Exception: ${e.message}';
      } else {
        throw 'Something Went Wrong! Please try again.';
      }
    }
  }
}