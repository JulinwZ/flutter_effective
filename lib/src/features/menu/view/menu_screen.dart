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

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  final List<Category> categories = [
    Category(
      name: 'Черный кофе',
      products: [
        Product(
            name: 'Американо',
            imageUrl: 'assets/images/coffe.png',
            price: '139 руб'),
        Product(
            name: 'Эспрессо',
            imageUrl: 'assets/images/coffe.png',
            price: '139 руб'),
        Product(
            name: 'Ванилька',
            imageUrl: 'assets/images/coffe.png',
            price: '139 руб'),
      ],
    ),
    Category(
      name: 'Кофе с молоком',
      products: [
        Product(
            name: 'Капучино',
            imageUrl: 'assets/images/coffe.png',
            price: '139 руб'),
        Product(
            name: 'Латте',
            imageUrl: 'assets/images/coffe.png',
            price: '139 руб'),
      ],
    ),
    Category(
      name: 'Чай',
      products: [
        Product(
            name: 'Зеленый',
            imageUrl: 'assets/images/coffe.png',
            price: '139 руб'),
        Product(
            name: 'Черный',
            imageUrl: 'assets/images/coffe.png',
            price: '139 руб'),
        Product(
            name: 'Улун',
            imageUrl: 'assets/images/coffe.png',
            price: '139 руб'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Черный кофе',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue)),
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Кофе с молоком',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Чай',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Авторские напитки',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
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
                                        fontSize: 16.0),
                                  ),
                                  SizedBox(height: 8),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      '${product.price}',
                                      textAlign: TextAlign.center,
                                    ),
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      textStyle: TextStyle(fontSize: 12),
                                      minimumSize: Size(116, 32),
                                    ),
                                  ),
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
