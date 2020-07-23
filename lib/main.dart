import 'package:cadastro_produtos/pages/home_page.dart';
import 'package:cadastro_produtos/pages/product_list.dart';
import 'package:cadastro_produtos/pages/product_register.dart';
import 'package:cadastro_produtos/utils/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      routes: {
        AppRoutes.HOME_PAGE: (ctx) => HomePage(),
        AppRoutes.LIST_PAGE: (ctx) => ProductList(),
        AppRoutes.REGISTER_PAGE: (ctx) => ProductRegister(),
      },
    );
  }
}
