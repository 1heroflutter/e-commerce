import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  final String productId;
  final String categoryId;

  ProductCategoryModel({required this.categoryId, required this.productId});

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'categoryId': categoryId
    };
  }

  factory ProductCategoryModel.fromSnapShot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductCategoryModel(categoryId: data['productId'] as String,
        productId: data['categoryId'] as String);
  }
}