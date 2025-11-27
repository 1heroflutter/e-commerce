
import 'package:e_commerce_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:e_commerce_app/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:e_commerce_app/features/personalization/screens/settings/setting.dart';
import 'package:e_commerce_app/routes/routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../features/authentication/screens/login/login.dart';
import '../features/authentication/screens/signup/signup.dart';
import '../features/authentication/screens/signup/verify_email.dart';
import '../features/personalization/screens/address/address.dart';
import '../features/personalization/screens/profile/profile.dart';
import '../features/shop/models/product_model.dart';
import '../features/shop/screens/cart/cart.dart';
import '../features/shop/screens/checkout/checkout.dart';
import '../features/shop/screens/home/home.dart';
import '../features/shop/screens/order/order.dart';
import '../features/shop/screens/product_details/product_detail.dart';
import '../features/shop/screens/store/screens/store/store.dart';
import '../features/shop/screens/wishlist/screens/favourite.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: Routes.home, page: () =>  HomeScreen()),
    GetPage(name: Routes.store, page: () => const StoreScreen()),
    GetPage(name: Routes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: Routes.settings, page: () => const SettingScreen()),
    GetPage(name: Routes.productReviews, page: () => ProductDetail(product: ProductModel.empty(),)),
    GetPage(name: Routes.order, page: () => const OrderScreen()),
    GetPage(name: Routes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: Routes.cart, page: () => const CartScreen()),
    GetPage(name: Routes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: Routes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: Routes.signup, page: () => const SignupScreen()),
    GetPage(name: Routes.verifyEmail, page: () => const VerifyEmailScreen()),
    GetPage(name: Routes.signIn, page: () => const LoginScreen()),
    GetPage(name: Routes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: Routes.onBoarding, page: () => const OnboardingScreen()),
    // Add more GetPage entries as needed
  ];
}