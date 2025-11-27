import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widgets/exceptions/firebase_exception.dart';
import 'package:e_commerce_app/common/widgets/exceptions/format_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common/widgets/exceptions/platform_exception.dart';
import '../../../features/shop/screens/home/models/banner_model.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all order related to current User
  Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db.collection('Banners').where('Active', isEqualTo: true).get();
      return result.docs.map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot)).toList();
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:e.code).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners.';
    }
  }
}