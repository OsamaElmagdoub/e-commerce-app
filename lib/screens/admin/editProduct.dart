import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/store.dart';
import 'package:ecommerce/widgets/custom_texfield.dart';
import 'package:flutter/material.dart';
class EditProduct extends StatelessWidget {
static String id = 'editProduct';
String _name, _price, _discription, _category, _imageloction;

final _store=Store();

final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

@override
  Widget build(BuildContext context) {
Product product=  ModalRoute.of(context).settings.arguments;
  return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.2,
            ),
            Column(
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
_store.editProduct(

{

  kProductName : _name,
  kProductPrice:_price,
  KProductLocation : _imageloction,

  kProductDescription : _discription,
  kProductCategory : _category
}

,product.pId);
                      }
                    },
                    child: Text('Update'))
              ],
            ),
          ],
        )
      ),
    );
  }
}
