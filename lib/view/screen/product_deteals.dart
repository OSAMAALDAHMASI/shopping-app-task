import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../data/model/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  CartAddController controller = Get.put(CartAddController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title),
        actions: [
          IconButton(
            icon: Icon(
                controller.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: controller.isFavorite ? Colors.red : Colors.black,
            onPressed: () {
              setState(() {
                controller.isFavorite = !controller.isFavorite;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.product.image,
                fit: BoxFit.cover,
                height: 300.0,
                width: double.infinity,
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.product.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '\$${widget.product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '${widget.product.rating.rate} (${widget.product.rating.count})',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.addToCart(widget.product, context);
                    },
                    icon: Icon(Icons.add_shopping_cart),
                    label: Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0), // لون النص
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
