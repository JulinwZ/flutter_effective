import 'package:flutter/material.dart';

class Product {
  final String name;
  final String imageUrl;
  final String price;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

class Category {
  final String name;
  final List<Product> products;

  Category({
    required this.name,
    required this.products,
  });
}

class MenuScreen extends StatefulWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<Category> categories = [
    Category(
      name: 'Черный кофе',
      products: [
        Product(
          name: 'Американо',
          imageUrl: 'assets/images/coffe.png',
          price: '139 руб',
        ),
        Product(
          name: 'Эспрессо',
          imageUrl: 'assets/images/coffe.png',
          price: '139 руб',
        ),
        Product(
          name: 'Ванилька',
          imageUrl: 'assets/images/coffe.png',
          price: '139 руб',
        ),
      ],
    ),
    Category(
      name: 'Кофе с молоком',
      products: [
        Product(
          name: 'Капучино',
          imageUrl: 'assets/images/coffe.png',
          price: '139 руб',
        ),
        Product(
          name: 'Латте',
          imageUrl: 'assets/images/coffe.png',
          price: '139 руб',
        ),
      ],
    ),
    Category(
      name: 'Чай',
      products: [
        Product(
          name: 'Зеленый',
          imageUrl: 'assets/images/coffe.png',
          price: '139 руб',
        ),
        Product(
          name: 'Черный',
          imageUrl: 'assets/images/coffe.png',
          price: '139 руб',
        ),
        Product(
          name: 'Улун',
          imageUrl: 'assets/images/coffe.png',
          price: '139 руб',
        ),
      ],
    ),
    Category(
      name: 'Напитки авторские',
      products: [
        Product(
          name: 'Зеленый',
          imageUrl: 'assets/images/coffe.png',
          price: '139 руб',
        ),
        Product(
          name: 'Черный',
          imageUrl: 'assets/images/coffe.png',
          price: '139 руб',
        ),
        Product(
          name: 'Улун',
          imageUrl: 'assets/images/coffe.png',
          price: '139 руб',
        ),
      ],
    ),
  ];

  int _selectedCategoryIndex = 0;
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: List.generate(categories.length, (index) {
                      final categoryName = categories[index].name;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedCategoryIndex = index;
                            });
                            _controller.animateTo(
                              index * 300.0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(
                            categoryName,
                            style: TextStyle(
                              color: _selectedCategoryIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              _selectedCategoryIndex == index
                                  ? Colors.blue
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        categories[index].name,
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories[index].products.length,
                        itemBuilder: (BuildContext context, int productIndex) {
                          final product =
                              categories[index].products[productIndex];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    product.imageUrl,
                                    width: 100,
                                    height: 100,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    product.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  ProductPriceButton(product: product),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              childCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductPriceButton extends StatefulWidget {
  final Product product;

  const ProductPriceButton({Key? key, required this.product}) : super(key: key);

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
          setState(() {
            _quantity++;
          });
        },
        child: Text(
          widget.product.price,
          textAlign: TextAlign.center,
        ),
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: TextStyle(fontSize: 12),
          minimumSize: Size(116, 32),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _quantity = (_quantity - 1).clamp(0, 10);
                });
              },
              icon: Icon(Icons.remove),
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '$_quantity',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _quantity = (_quantity + 1).clamp(0, 10);
                });
              },
              icon: Icon(Icons.add),
              color: Colors.white,
            ),
          ),
        ],
      );
    }
  }
}
