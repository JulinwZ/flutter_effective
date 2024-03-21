import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/models.dart';

class ProductPriceButton extends StatefulWidget {
  final Product product;
  final Function(Product) addToCart;
  final Function(Product) removeFromCart;

  const ProductPriceButton(
      {Key? key, required this.product, required this.addToCart,required this.removeFromCart})
      : super(key: key);

  @override
  _ProductPriceButtonState createState() => _ProductPriceButtonState();
}

class _ProductPriceButtonState extends State<ProductPriceButton> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    if (_quantity == 0) {
      return TextButton(
        onPressed: () {
          if (_quantity < 10) {
            setState(() {
              _quantity++;
              widget.addToCart(widget.product);
            });
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
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _quantity -= 1;
                    widget.removeFromCart(widget.product);
                  });
                },
                icon: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 12,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 52,
            height: 24,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue),
            child: Center(
              child: Text(
                '$_quantity',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            )
          ),
          SizedBox(width: 8),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: Center(
              child: IconButton(
                onPressed: () {
                  if (_quantity < 10) {
                    setState(() {
                      _quantity++;
                      widget.addToCart(widget.product);
                    });
                  }
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 12,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      );
    }
  }
}
