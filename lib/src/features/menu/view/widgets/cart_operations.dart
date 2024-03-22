import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/models.dart';

class CartOperations {
  static void addToCart(Product product, List<Pair<Product, int>> selectedProducts, Function setState) {
    setState(() {
      bool alreadyInCart = false;
      for (int i = 0; i < selectedProducts.length; i++) {
        if (selectedProducts[i].first == product) {
          selectedProducts[i] =
              Pair(selectedProducts[i].first, selectedProducts[i].second + 1);
          alreadyInCart = true;
          break;
        }
      }
      if (!alreadyInCart) {
        selectedProducts.add(Pair(product, 1));
      }
    });
  }

  static void removeFromCart(Product product, List<Pair<Product, int>> selectedProducts, Function setState) {
    setState(() {
      for (int i = 0; i < selectedProducts.length; i++) {
        if (selectedProducts[i].first == product) {
          selectedProducts[i] =
              Pair(selectedProducts[i].first, selectedProducts[i].second - 1);
          if (selectedProducts[i].second <= 0) {
            selectedProducts.removeAt(i);
          }
          break;
        }
      }
    });
  }

  static void clearCart(List<Pair<Product, int>> selectedProducts, Function setState) {
    setState(() {
      selectedProducts.clear();
    });
  }
}
