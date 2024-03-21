import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/view/widgets/models.dart';
import 'package:flutter_course/src/features/menu/view/widgets/api_service.dart';
import 'package:flutter_course/src/features/menu/view/widgets/product_price_button.dart';
import 'package:flutter_course/src/features/menu/view/widgets/sliver_app_bar.dart';

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
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final categoriesData = await ApiService.fetchData();
      setState(() {
        categories = categoriesData;
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
      backgroundColor: Color(0xFFF7FAF8),
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          CustomSliverAppBar(
            categories: categories,
            selectedCategoryIndex: _selectedCategoryIndex,
            onCategorySelected: (index) {
              setState(() {
                _selectedCategoryIndex = index;
              });
              _controller.animateTo(
                index * 300.0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
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
                              color: Colors.white,
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
