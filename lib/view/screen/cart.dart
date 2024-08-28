import 'package:flutter/material.dart';
import 'package:shopping_app_task/view/screen/payment.dart';
import '../../controller/cart_controller.dart';


class CartPage extends StatelessWidget {
  final CartController controller = CartController();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Cart'),
      ),
      body: FutureBuilder(
        future: controller.fetchCartsByUser(),
        builder: (context, snapshot) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.carts.isEmpty) {
            return const Center(child: Text('No carts found.'));
          }
          return ListView.builder(
            itemCount: controller.carts.length,
            itemBuilder: (context, index) {
              final cart = controller.carts[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cart ID: ${cart.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('Date: ${cart.date}'),
                      const SizedBox(height: 10),
                      const Text('Products:', style: TextStyle(fontWeight: FontWeight.bold)),
                      ...cart.products.map((product) {
                        return ListTile(
                          title: Text(product.title),
                          subtitle: Text('Price: \$${product.price}'),
                          leading: Image.network(product.image, width: 50),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PaymentPage()), // تأكد من وجود PaymentPage
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(vertical: 16.0), // لون النص
          ),
          child: const Text('Proceed to Payment'),
        ),
      ),
    );
  }
}