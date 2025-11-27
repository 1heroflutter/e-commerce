import 'package:e_commerce_app/features/shop/controllers/product/variation_controller.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../models/cart_item_model.dart';
import '../../models/product_model.dart';
class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt noOfCartItems = 0.obs;
  RxDouble totalPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController(){
    loadCartItems();
  }
  /// Add items in the cart
  void addToCart(ProductModel product) {
    // Quantity Check
    if (productQuantityInCart.value < 1) {
      Loaders.customToast(message: 'Select Quantity');
      return;
    }

    // Variation Selected?
    if (product.productType == ProductType.variable.toString() && variationController.selectedVariation.value.id.isEmpty) {
      Loaders.customToast(message: 'Select Variation');
      return;
    }

    // Out of Stock Status
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        Loaders.warningSnackBar(message: 'Selected variation is out of stock.', title: 'Oh Snap!');
        return;
      }
    } else {
      if (product.stock < 1) {
        Loaders.warningSnackBar(message: 'Selected Product is out of stock.', title: 'Oh Snap!');
        return;
      }
    }

    final selectedCartItem = convertToCartItem(product, productQuantityInCart.value);
    int index = cartItems.indexWhere((cartItem) => cartItem.productId==selectedCartItem.productId&& cartItem.variationId==selectedCartItem.variationId,);
    if(index>= 0){
      cartItems[index].quantity = selectedCartItem.quantity;
    }else{
      cartItems.add(selectedCartItem);
    }
    Loaders.customToast(message: 'Your Product has been added to the cart');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
    cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
    cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if(cartItems[index].quantity>1){
        cartItems[index].quantity-=1;
      }else {
        cartItems[index].quantity==1? removeFromCartDialog(index):cartItems.removeAt(index);
      }
    }

    updateCart();
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        // Remove the item from the cart
        cartItems.removeAt(index);
        updateCart();
        Loaders.customToast(message: 'Product removed from the Cart.');
        Get.back();
      },
      onCancel: () => Get.back(),
    );
  }
  /// This function converts a ProductModel to a CartItemModel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      // Reset Variation in case of single product type.
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;

    final price = isVariation
        ? variation.salePrice > 0.0 ? variation.salePrice : variation.price
        : product.salePrice > 0.0 ? product.salePrice : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }
  // Giả định rằng các hàm này nằm bên trong `CartController`

  /// Update Cart Totals
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }
  /// -- Initialize already added Item's Count in the cart.
  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // Get selected Variation if any...
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value = getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    LocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  void loadCartItems() {
    final cartItemStrings = LocalStorage.instance().readData<List<dynamic>>('cartItems');

    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings.map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem =
    cartItems.where((item) => item.productId == productId).fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
          (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );

    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}