import 'package:e_commerce_app/common/widgets/loaders/loaders.dart';
import 'package:e_commerce_app/data/repositories/banners/banner_repository.dart';
import 'package:e_commerce_app/features/shop/screens/home/models/banner_model.dart';
import 'package:get/get.dart';
class BannerController extends GetxController {
  /// Variables
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  /// Update Page Navigational Dots
  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  /// Fetch Banners
  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      this.banners.assignAll(banners);
      isLoading.value = false;

    } catch (e) {
      Loaders.errorSnackbar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Remove Loader
      isLoading.value = false;
    }
  }
}