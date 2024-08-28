
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User {
  final int id;
  final String email;
  final String username;
  final String firstname;
  final String lastname;
  final String phone;
  final String street;
  final String city;
  final String zipcode;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.phone,
    required this.street,
    required this.city,
    required this.zipcode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      firstname: json['name']['firstname'],
      lastname: json['name']['lastname'],
      phone: json['phone'],
      street: json['address']['street'],
      city: json['address']['city'],
      zipcode: json['address']['zipcode'],
    );
  }
}

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<User> users = [];

  Future<void> fetchUsers() async {
    final url = Uri.parse('https://fakestoreapi.com/users');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          users = jsonResponse.map((user) => User.fromJson(user)).toList();
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers(); // جلب البيانات عند بدء الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text('${user.firstname} ${user.lastname}'),
            subtitle: Text('Email: ${user.email}'),
            trailing: Text('Phone: ${user.phone}'),
          );
        },
      ),
    );
  }
}