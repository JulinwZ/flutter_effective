import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        imageUrl: json['imageUrl'] as String,
        price: json['prices'][0]['value'] as String);
  }
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
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await Dio().get(
        'https://coffeeshop.academy.effective.band/api/v1/products/?page=0&limit=10',
      );

      final List<dynamic> productsData = response.data['data'] as List<dynamic>;
      final Map<String, List<Product>> groupedProducts = {};

      productsData.forEach((productJson) {
        final product = Product.fromJson(productJson as Map<String, dynamic>);
        final categoryName = productJson['category']['slug'] as String;

        if (!groupedProducts.containsKey(categoryName)) {
          groupedProducts[categoryName] = [];
        }
        groupedProducts[categoryName]!.add(product);
      });

      setState(() {
        categories = groupedProducts.entries.map((entry) {
          return Category(name: entry.key, products: entry.value);
        }).toList();
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

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
                final category = categories[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        category.name,
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 196,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: category.products.length,
                        itemBuilder: (BuildContext context, int productIndex) {
                          final product = category.products[productIndex];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
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
                    _quantity = (_quantity - 1).clamp(0, 10);
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
              )),
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
                  setState(() {
                    _quantity = (_quantity + 1).clamp(0, 10);
                  });
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
