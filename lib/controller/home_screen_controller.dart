import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../data/model/product_model.dart';
abstract class HomeScreenController extends GetxController{

}

class HomeScreenControllerImp extends HomeScreenController{
  late Future<List<Product>> productsFuture;
  List<Product> myProducts = [];
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
   getData();
  }
getData()async{
  productsFuture = fetchProducts();
  productsFuture.then((products) {
    myProducts = products;
      filteredProducts = products;
      update();
  });
  update();
}
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }

  }


  search(value)
  {
    if(value==null)
      {
        filteredProducts=myProducts;
      }
    filteredProducts = myProducts.where((product) {
      return product.title.toLowerCase().contains(value.toLowerCase());
    }).toList();
    update();
  }
}