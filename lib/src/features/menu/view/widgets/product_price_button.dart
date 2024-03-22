import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/models.dart';

class ProductPriceButton extends StatefulWidget {
  final Product product;
  final Function(Product) addToCart;
  final Function(Product) removeFromCart;
  final List<Pair<Product, int>> selectedProducts;

  const ProductPriceButton({
    Key? key,
    required this.product,
    required this.addToCart,
    required this.removeFromCart,
    required this.selectedProducts,
  }) : super(key: key);

  @override
  _ProductPriceButtonState createState() => _ProductPriceButtonState();
}

class _ProductPriceButtonState extends State<ProductPriceButton> {
  @override
  Widget build(BuildContext context) {
    final selectedQuantity =
        widget.selectedProducts.firstWhere((pair) => pair.first == widget.product, orElse: () => Pair(widget.product, 0)).second;

    if (selectedQuantity == 0) {
      return TextButton(
        onPressed: () {
          if (selectedQuantity < 10) {
            widget.addToCart(widget.product);
          }
        },
        child: Text(
          widget.product.price.toString(),
          textAlign: TextAlign.center,
        ),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          textStyle: TextStyle(fontSize: 12),
          minimumSize: Size(116, 32),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (selectedQuantity > 0) {
                widget.removeFromCart(widget.product);
              }
            },
            icon: Icon(
              Icons.remove,
              color: Colors.blue,
              size: 16,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '$selectedQuantity',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () {
              if (selectedQuantity < 10) {
                widget.addToCart(widget.product);
              }
            },
            icon: Icon(
              Icons.add,
              color: Colors.blue,
              size: 16,
            ),
          ),
        ],
      );
    }
  }
}
