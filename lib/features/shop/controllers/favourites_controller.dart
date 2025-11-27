import 'dart:convert';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/product/product_repository.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../models/product_model.dart';

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  // Variables
  final favorites = <String, bool>{}.obs;
  final isReady = false.obs;
  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  // Method to initialize favorites by reading from storage
  void initFavorites() {
    final json = LocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;

      final validFavorites = storedFavorites.map((key, value) => MapEntry(key, value as bool));
      validFavorites.removeWhere((key, value) => key.isEmpty);
      favorites.assignAll(validFavorites);
      favorites.forEach((key, value) => print('---------fav check---------: [$key = $value]'),);
    }
    isReady.value = true;
  }

  bool isFavourite(String productId) {
    return favorites[productId] ?? false;
  }

  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      Loaders.customToast(message: 'Product has been added to the Wishlist.');
    } else {
      LocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      Loaders.customToast(message: 'Product has been removed from the Wishlist.');
    }
  }

  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    LocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    final productIds = favorites.keys.toList();
    if (productIds.isEmpty) {
      return [];
    }
    return await ProductRepository.instance.getFavouriteProducts(productIds);
  }
}