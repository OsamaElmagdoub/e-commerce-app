import 'package:ecommerce/functions.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/user/productInfo.dart';
import 'package:flutter/material.dart';
Widget productView(String pCategory,List <Product> allProducts) {
  List<Product> products;
  products = getProductsByCategory(pCategory,allProducts);
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.8),
    itemBuilder: (context, index) =>
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
onTap: (){

  Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
},
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    products[index].pLocation,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.4,
                    child: Container(
                      height: 60,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].pName,
                              style:
                              TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '\$ ${products[index].pPrice}',
                              style:
                              TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    itemCount: products.length,
  );
}