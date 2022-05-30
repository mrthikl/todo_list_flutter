import 'package:flutter/material.dart';
import 'package:todo_app/helpers/drawer_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo list'),
      ),
      drawer: DrawerNavigation(),
    );
  }
}
