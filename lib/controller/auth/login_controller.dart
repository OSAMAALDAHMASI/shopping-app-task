import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app_task/view/screen/home.dart';

abstract class LoginController extends GetxController {}

class LoginControllerImp extends LoginController {
  bool isLoading = false;
  String? myToken;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  

  Future<void> login(context) async {
    isLoading = true;
    update();

    final url = Uri.parse('https://fakestoreapi.com/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': emailController.text.trim(), // "mor_2314"
          'password': passwordController.text.trim(), //     "83r5^_"
        }),
      );

      if (response.statusCode == 200) {
        // Successful login
        final jsonResponse = jsonDecode(response.body);
        myToken = jsonResponse["token"];
        print("myToken:$myToken");
        // Handle successful response (e.g., navigate to another page)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),

        );
        Get.off(HomeScreen());
      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response.statusCode}')),
        );
      }
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    } finally {
      isLoading = false;
      update();
    }
    print(emailController.text);
    print(passwordController.text);
  }

}
