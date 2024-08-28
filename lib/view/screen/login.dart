
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopping_app_task/controller/auth/login_controller.dart';
import 'package:shopping_app_task/view/screen/sign_up.dart';

class LoginPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: 'User Name'
                      '',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white54,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white54,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30),
              GetBuilder<LoginControllerImp>(builder: (controller)=>ElevatedButton(
                onPressed: (){controller.isLoading ? null : controller.login(context);},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blueAccent, backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: controller.isLoading
                    ? CircularProgressIndicator(color: Colors.blueAccent)
                    : Text('Login'),
              )),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.off(SignUpPage());
                },
                child: Text(
                  'Don\'t have an account? Sign up here',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}