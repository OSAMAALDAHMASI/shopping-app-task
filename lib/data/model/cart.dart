import 'package:shopping_app_task/data/model/product_model.dart';

class Cart {
  final int id;
  final int userId;
  final String date;
  final List<Product> products;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<Product> productItems = productList.map((i) => Product.fromJson(i)).toList();

    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: productItems,
    );
  }
}