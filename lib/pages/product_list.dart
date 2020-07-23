import 'dart:io';

import 'package:cadastro_produtos/data/mock_data.dart';
import 'package:cadastro_produtos/utils/app_routes.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  static String routeName = '/product_list';
  @override
  _ProductListState createState() => _ProductListState();
}

class Arguments {
  int index;
  Arguments({this.index});
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de produtos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => GestureDetector(
            child: Image.file(
              File(MockData.products.elementAt(index).image),
              fit: BoxFit.cover,
            ),
            onTap: () async {
              await Navigator.of(context).pushNamed(AppRoutes.REGISTER_PAGE,
                  arguments: Arguments(index: index));
              setState(() {});
            },
            onLongPress: () {
              return showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text(
                      '${MockData.products.elementAt(index).name}',
                    ),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '${MockData.products.elementAt(index).description}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  );
                },
                //itemCount: MockData.products.length,
              );
            },
          ),
          itemCount: MockData.products.length,
        ),
      ),
    );
  }
}
