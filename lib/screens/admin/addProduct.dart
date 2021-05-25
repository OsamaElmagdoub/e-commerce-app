
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/store.dart';
import 'package:ecommerce/widgets/custom_texfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  static String id = 'addProduct';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String _name, _price, _discription, _category, _imageloction;

  final _store=Store();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              'Product Name',
              null,
              onclick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              'Product price',
              null,
              onclick: (value) {
                _price = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              'Product discription',
              null,
              onclick: (value) {
                _discription = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              'Product category',
              null,
              onclick: (value) {
                _category = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              'Product Location',
              null,
              onclick: (value) {
                _imageloction = value;
              },
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_globalKey.currentState.validate()) {
                    _globalKey.currentState.save();

                  _store.addproduct(Product(

                    pName: _name,
                    pPrice: _price,
                    pDescription: _category,
                    pCategory: _category,
                    pLocation: _imageloction,


                  ));
                  }
                },
                child: Text('Add'))
          ],
        ),
      ),
    );
  }
}
