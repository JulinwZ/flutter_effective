class Product {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;

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
      price: double.parse(json['prices'][0]['value'] as String),
    );
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

class Pair<A, B> {
  final A first;
  final B second;

  Pair(this.first, this.second);
}

class PaymentData {
  late Map<int, int> positions;
  late String token;

  PaymentData(this.positions, this.token);

  Map<String, dynamic> toJson() {
    return {
      'positions': positions.map(
          (productId, quantity) => MapEntry(productId.toString(), quantity)),
      'token': token,
    };
  }
}
