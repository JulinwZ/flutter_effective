import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/models.dart';

class CartButton extends StatelessWidget {
  final List<Pair<Product, int>> selectedProducts;

  const CartButton({Key? key, required this.selectedProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalCost = selectedProducts.fold(
      0,
      (previousValue, pair) => previousValue + (pair.first.price * pair.second),
    );

    return Positioned(
      bottom: 20.0,
      right: 20.0,
      child: Column(
        children: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          Text(totalCost.toString()),
        ],
      ),
    );
  }
}
