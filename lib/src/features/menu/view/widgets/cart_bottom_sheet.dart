import 'package:flutter/material.dart';
import 'package:flutter_course/src/features/menu/view/widgets/models.dart';
import 'package:flutter_course/src/features/menu/view/widgets/api_service.dart';

class CartBottomSheet extends StatelessWidget {
  final List<Pair<Product, int>> selectedProducts;
  final double totalCost;
  final VoidCallback onClear;

  const CartBottomSheet(
      {Key? key,
      required this.selectedProducts,
      required this.totalCost,
      required this.onClear})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ваш заказ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  onClear();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: selectedProducts.length,
              itemBuilder: (context, index) {
                final Pair<Product, int> pair = selectedProducts[index];
                return ListTile(
                  title: Text(pair.first.name),
                  subtitle: Text('Количество: ${pair.second}'),
                  trailing: Text(
                      'Цена: ${(pair.first.price * pair.second).toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Всего: ${totalCost.toStringAsFixed(2)} \₽',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final Map<int, int> positions = {};
              selectedProducts.forEach((pair) {
                final productId = pair.first.id;
                final quantity = pair.second;
                positions[productId] = quantity;
              });

              final paymentData = PaymentData(positions, '');
              ApiService.makePayment(paymentData).then((success) {
                if (success) {
                  onClear();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Заказ успешно оформлен!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ошибка при оформлении заказа!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              });
            },
            child: Text('Оплатить'),
          ),
        ],
      ),
    );
  }
}
