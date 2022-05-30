import 'package:flutter/material.dart';
import 'package:todo_app/screen/categories_screen.dart';

import 'package:todo_app/screen/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  DrawerNavigation({Key? key}) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.hola.com/us/images/026f-13ac8cc84b8c-e186928dd1f4-1000/horizontal-480/a-cat-playing-in-a-yard-in-beijing-china.jpg'),
            ),
            accountName: Text('Thi nguyen'),
            accountEmail: Text('admin@gmail.com'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen())),
          ),
          ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoriesScreen()))),
        ]),
      ),
    );
  }
}
