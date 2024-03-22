import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/cart_bottom_sheet.dart';
import 'package:flutter_course/src/features/menu/view/widgets/models.dart';

class CartButton extends StatelessWidget {
  final List<Pair<Product, int>> selectedProducts;
  final VoidCallback onClear;

  const CartButton({Key? key, required this.selectedProducts, required this.onClear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool empty = false;
    if (selectedProducts.isEmpty) {
      empty = false;
    } else {
      empty = true;
    }
    double totalCost = selectedProducts.fold(
      0,
      (previousValue, pair) => previousValue + (pair.first.price * pair.second),
    );

    return Positioned(
        bottom: 20.0,
        right: 20.0,
        child: Visibility(
          visible: empty,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.all(8),
                child: TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => CartBottomSheet(
                        selectedProducts: selectedProducts,
                        totalCost: totalCost,
                        onClear: onClear,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white, // цвет иконки
                  ),
                  label: Text(
                    totalCost.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white, // цвет текста
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),



            ],
          ),
        ));
  }
}
