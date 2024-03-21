import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  final double totalCost = 0;
  final VoidCallback onPressed;

  const CartButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 20.0,
        right: 20.0,
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: onPressed,
            ),
            Text(totalCost.toString()),
          ],
        ));
  }
}
