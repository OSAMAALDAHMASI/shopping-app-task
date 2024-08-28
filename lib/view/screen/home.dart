

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app_task/view/screen/product_deteals.dart';

import '../../controller/home_screen_controller.dart';
import '../widget/product_card.dart';
import 'cart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenControllerImp controller = Get.put(HomeScreenControllerImp());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: TextField(
          controller: controller.searchController,
          onChanged: (value) {
            controller.search(value);
          },
          decoration: const InputDecoration(
            hintText: 'Search products',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()), // تأكد من وجود CartPage
              );
            },
          ),
        ],
      ),
      body: Container(
        child: GetBuilder<HomeScreenControllerImp>(
          builder: (controller) => Container(
            child: controller.filteredProducts.isEmpty
                ? const Center(child: Text('No products found'))
                : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: controller.filteredProducts.length,
              itemBuilder: (context, index) {
                final product = controller.filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: GetBuilder<HomeScreenControllerImp>(
                    builder: (controller) => ProductCard(product: product),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartPage()), // تأكد من وجود CartPage
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.shopping_cart,color: Colors.white,),
      ),
    );
  }
}





