import 'package:ecommerce/constants.dart';
import 'package:ecommerce/screens/admin/OrdersScreen.dart';
import 'package:ecommerce/screens/admin/addProduct.dart';
import 'package:ecommerce/screens/admin/manageProduct.dart';
import 'package:flutter/material.dart';
class AdminHome extends StatelessWidget {
 static String id = 'adminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMaincolor,
      body: Center(
child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    ElevatedButton(
      // style: ButtonStyle(
      //
      //     backgroundColor: MaterialStateProperty.all<Color>(KSecondColor)
      //
      //
      //
      // ),
        onPressed: (){
          Navigator.of(context).pushNamed(AddProduct.id);

        }, child: Text('Add Product'))
    ,

    ElevatedButton(onPressed: (){
     Navigator.pushNamed(context, ManageProduct.id);
    }, child: Text('Edit product')),

    ElevatedButton(onPressed: (){
      Navigator.pushNamed(context, OrdersScreen.id);
    }, child: Text('View orders'))
  ],
),

      ),

    );
  }
}
