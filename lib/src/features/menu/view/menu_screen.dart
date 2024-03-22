import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/models.dart';
import 'package:flutter_course/src/features/menu/view/widgets/api_service.dart';
import 'package:flutter_course/src/features/menu/view/widgets/product_price_button.dart';
import 'package:flutter_course/src/features/menu/view/widgets/sliver_app_bar.dart';
import 'package:flutter_course/src/features/menu/view/widgets/custom_sliver_list.dart';
import 'package:flutter_course/src/features/menu/view/widgets/cart_button.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Category> categories = [];
  List<Pair<Product, int>> selectedProducts = [];

  void onClear() {
    setState(() {
      selectedProducts.clear();
    });
  }

  void addToCart(Product product) {
    setState(() {
      bool alreadyInCart = false;
      for (int i = 0; i < selectedProducts.length; i++) {
        if (selectedProducts[i].first == product) {
          selectedProducts[i] =
              Pair(selectedProducts[i].first, selectedProducts[i].second + 1);
          alreadyInCart = true;
          break;
        }
      }
      if (!alreadyInCart) {
        selectedProducts.add(Pair(product, 1));
      }
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      for (int i = 0; i < selectedProducts.length; i++) {
        if (selectedProducts[i].first == product) {
          selectedProducts[i] =
              Pair(selectedProducts[i].first, selectedProducts[i].second - 1);
          if (selectedProducts[i].second <= 0) {
            selectedProducts.removeAt(i);
          }
          break;
        }
      }
    });
  }

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
      body: Stack(
        children: [
          CustomScrollView(
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
              CustomSliverList(
                categories: categories,
                addToCart: addToCart,
                removeFromCart: removeFromCart,
              ),
            ],
          ),
          CartButton(
            selectedProducts: selectedProducts,
            onClear: onClear,
          ),
        ],
      ),
    );
  }
}
