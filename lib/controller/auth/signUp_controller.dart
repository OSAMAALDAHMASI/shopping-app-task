import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app_task/view/screen/login.dart';
class SignUpController extends GetxController {
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var cityController = TextEditingController();
  var streetController = TextEditingController();
  var numberController = TextEditingController();
  var zipcodeController = TextEditingController();
  var phoneController = TextEditingController();

  var isLoading = false.obs;
  int? myId;






  Future<void> signUp(BuildContext context) async {
    isLoading.value = true;

    final url = Uri.parse('https://fakestoreapi.com/users');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': emailController.text,
        'username': usernameController.text,
        'password': passwordController.text,
        'name': {
          'firstname': firstnameController.text,
          'lastname': lastnameController.text,
        },
        'address': {
          'city': cityController.text,
          'street': streetController.text,
          'number': int.parse(numberController.text),
          'zipcode': zipcodeController.text,
          'geolocation': {
            'lat': '-37.3159',
            'long': '81.1496',
          },
        },
        'phone': phoneController.text,
      }),
    );

    isLoading.value = false;
    update();

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      myId =jsonResponse['id'];
      print('User created: $jsonResponse');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('successful!')),

      );
      Get.offAll(LoginPage());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create user')),
      );
      print('Failed to create user: ${response.statusCode}');

    }
  }
}