import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/models.dart';
import 'package:flutter_course/src/features/menu/view/widgets/product_price_button.dart';

class CustomSliverList extends StatelessWidget {
  final List<Category> categories;

  const CustomSliverList({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
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
    );
  }
}
