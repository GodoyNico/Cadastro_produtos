import 'package:cadastro_produtos/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home Page'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.HOME_PAGE);
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('List Page'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.LIST_PAGE);
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Cadastro'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.REGISTER_PAGE);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text(
          'Seja bem vindo',
          style: TextStyle(fontSize: 26),
        ),
      ),
    );
  }
}
