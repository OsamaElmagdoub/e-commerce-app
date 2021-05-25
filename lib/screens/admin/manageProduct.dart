import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/admin/editProduct.dart';
import 'package:ecommerce/services/store.dart';
import 'package:ecommerce/widgets/custom-menu.dart';
import 'package:flutter/material.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  @override
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: _store.loadProducts(),
            builder: (context, snapshot) {
              List<Product> products = [];

              if (snapshot.hasData) {
                for (var doc in snapshot.data.docs) {
                  var data = doc.data();

                  products.add(Product(
                    pId: doc.id,
                    pName: data[kProductName],
                    pLocation: data[KProductLocation],
                    pCategory: data[kProductCategory],
                    pDescription: data[kProductDescription],
                    pPrice: data[kProductPrice],
                  ));
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTapUp: (details) {
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery.of(context).size.width - dx;
                        double dy2 = MediaQuery.of(context).size.height - dy;
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dy2, dy2),
                            items: [
                              MyPopupMenuItem(
                                onclick: () {
                                  return Navigator.pushNamed(
                                      context, EditProduct.id,
                                      arguments: products[index]);
                                },
                                child: Text('Edit'),
                              ),
                              MyPopupMenuItem(
                                  onclick: () {
                                    _store.deleteProduct(products[index].pId);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Delete'))
                            ]);
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
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[index].pName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\$ ${products[index].pPrice}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
