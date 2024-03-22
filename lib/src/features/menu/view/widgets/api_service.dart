import 'package:dio/dio.dart';
import 'package:flutter_course/src/features/menu/view/widgets/models.dart';
import 'dart:convert';

class ApiService {
  static Future<List<Category>> fetchData() async {
    try {
      final response = await Dio().get(
        'https://coffeeshop.academy.effective.band/api/v1/products/?page=0&limit=50',
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

      final categories = groupedProducts.entries.map((entry) {
        return Category(name: entry.key, products: entry.value);
      }).toList();

      return categories;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  static Future<bool> makePayment(PaymentData paymentData) async {
    try {
      final response = await Dio().post(
        'https://coffeeshop.academy.effective.band/api/v1/orders',
        data: paymentData.toJson(),
      );

      print('Payment response: ${response.statusCode}');
      return true;
    } catch (e) {
      print('Error making payment: $e');
      return false;
    }
  }
}
