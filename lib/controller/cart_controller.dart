import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../data/model/cart.dart';
import 'auth/signUp_controller.dart';

class CartController extends ChangeNotifier {
  List<Cart> carts = [];
  var isLoading = false;

  Future<void> fetchCartsByUser() async {
    isLoading = true;
    notifyListeners();
    SignUpController signUpController = Get.put(SignUpController());

    final url = Uri.parse('https://fakestoreapi.com/carts/user/${signUpController.myId??7}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        carts = jsonResponse.map((cart) => Cart.fromJson(cart)).toList();
      } else {
        print('Failed to load carts: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }




}

class CartAddController extends GetxController{
  SignUpController signUpController = Get.put(SignUpController());
  bool isFavorite = false;
Future<void> addToCart(product,context) async {
  final url = Uri.parse('https://fakestoreapi.com/carts');

  final cartData = {
    'userId': signUpController.myId??7,
    'date': DateTime.now().toIso8601String(),
    'products': [
      {'productId': product.id, 'quantity': 1}, // استخدام معرف المنتج
    ],
  };

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(cartData),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added to cart: ${jsonResponse['id']}')),
      );
    } else {
      throw Exception('Failed to add to cart');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}
}