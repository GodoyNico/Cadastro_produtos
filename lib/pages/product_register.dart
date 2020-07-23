import 'dart:io';

import 'package:cadastro_produtos/data/mock_data.dart';
import 'package:cadastro_produtos/pages/product_list.dart';
import 'package:cadastro_produtos/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductRegister extends StatefulWidget {
  static String routeName = '/product_register';

  @override
  _ProductRegisterState createState() => _ProductRegisterState();
}

class _ProductRegisterState extends State<ProductRegister> {
  final _name = TextEditingController();
  final _description = TextEditingController();

  Product product = Product();

  final _image = ImagePicker();
  final _form = GlobalKey<FormState>();
  final _scaffold = GlobalKey<ScaffoldState>();

  Future<void> _takeImage(ImageSource source) async {
    var _file = await _image.getImage(source: source);
    if (_file != null) {
      setState(() {
        product.image = _file.path;
      });
    }
  }

  void save() {
    product.name = _name.text;
    product.description = _description.text;
    MockData.products.add(product);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Arguments argument = ModalRoute.of(context).settings.arguments;
    Future<void> _chooseImage(ImageSource source) async {
      var _file = await _image.getImage(source: source);
      if (_file != null) {
        setState(() {
          MockData.products[argument.index].image = _file.path;
        });
      }
    }

    if (argument != null) {
      _name.text = MockData.products[argument.index].name;
      _description.text = MockData.products[argument.index].description;
      product.image = MockData.products[argument.index].image;
    }

    void saveEdit() {
      setState(() {
        MockData.products[argument.index].name = _name.text;
        MockData.products[argument.index].description = _description.text;
        MockData.products[argument.index].image = product.image;
      });
    }

    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('Cadastrar produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                product.image == null
                    ? Text('Sem imagem')
                    : FadeInImage(
                        fit: BoxFit.fitHeight,
                        placeholder: AssetImage('assets/loading.gif'),
                        image: FileImage(
                          File(product.image),
                        ),
                      ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton.icon(
                        onPressed: () {
                          if (argument != null) {
                            _chooseImage(
                              ImageSource.camera,
                            );
                          } else {
                            _takeImage(
                              ImageSource.camera,
                            );
                          }
                        },
                        icon: Icon(Icons.camera_alt),
                        label: Text('Nova foto'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: RaisedButton.icon(
                        onPressed: () => _takeImage(ImageSource.gallery),
                        icon: Icon(Icons.photo_library),
                        label: Text('Selecionar foto'),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nome'),
                    controller: _name,
                    validator: (name) {
                      if ((name.length ?? 0) <= 3)
                        return 'O nome é muito curto';
                      if ((name.length ?? 0) >= 30)
                        return 'O nome é muito longo';
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Descrição'),
                    controller: _description,
                    validator: (description) {
                      if ((description.length ?? 0) <= 3)
                        return 'A descrição é muito curta';
                      if ((description.length ?? 0) >= 30)
                        return 'A descrição é muito longa';
                      return null;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      RaisedButton.icon(
                        onPressed: () {
                          if (product.image == null) {
                            _scaffold.currentState.showSnackBar(
                              SnackBar(
                                content: Text('Adicione uma foto'),
                              ),
                            );
                          } else {
                            if (_form.currentState.validate()) {
                              if (argument != null) {
                                saveEdit();
                              } else {
                                save();
                              }
                            }
                          }
                        },
                        icon: Icon(Icons.save),
                        label: Text('Cadastrar'),
                      ),
                      SizedBox(width: 5),
                      RaisedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.cancel),
                        label: Text('Cancelar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
