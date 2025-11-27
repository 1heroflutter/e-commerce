import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/common/widgets/exceptions/firebase_exception.dart';
import 'package:e_commerce_app/common/widgets/exceptions/format_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../common/widgets/exceptions/platform_exception.dart';
import '../../../features/shop/models/brand_model.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code:e.code).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code:e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Brands.';
    }
  }
  /// Get all categories
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      // 1. Truy vấn các BrandCategory
      final snapshot = await _db.collection('BrandCategory').where('categoryId', isEqualTo: categoryId).get();

      // 2. KIỂM TRA QUAN TRỌNG: Nếu không tìm thấy, trả về danh sách rỗng ngay lập tức
      if (snapshot.docs.isEmpty) {
        return []; // Trả về list rỗng
      }

      // 3. Bây giờ chúng ta biết snapshot không rỗng, ta có thể map an toàn
      List<String> brandIds = snapshot.docs.map((e) => e['brandId'] as String).toList();

      // 4. Thực hiện truy vấn thứ hai (lúc này brandIds chắc chắn không rỗng)
      final brandsQuery = await _db.collection('Brands').where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

      List<BrandModel> brands = brandsQuery.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return brands;

    } on FirebaseException catch (e) {
      throw BasicFirebaseException(code: e.code).message;
    } on FormatException catch (_) {
      throw const BasicFormatException();
    } on PlatformException catch (e) {
      throw BasicPlatformException(code: e.code).message;
    } catch (e, stackTrace) {
      // Giữ lại print lỗi để debug
      print('LỖI THỰC SỰ: $e');
      print('STACK TRACE: $stackTrace');
      throw 'Something went wrong while get Brands For Category.';
    }
  }

/// Get Brands For Category

}