import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/functions.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/screens/admin/cartScreen.dart';
import 'package:ecommerce/screens/user/login_screen.dart';
import 'package:ecommerce/screens/user/productInfo.dart';
import 'package:ecommerce/services/store.dart';
import 'package:ecommerce/widgets/productview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  static String id = 'homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabbarindex = 0;
  int _bottombarindex = 0;
  final _store = Store();
  List<Product> _products;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                fixedColor: KMaincolor,
                type: BottomNavigationBarType.fixed,
                currentIndex: _bottombarindex,
                onTap: (value) async{
                  if(value==2) {
SharedPreferences _pref=await SharedPreferences.getInstance();
_pref.clear();
_auth.signOut();
Navigator.popAndPushNamed(context,LoginScreen.id);

                  }
                  setState(() {
                    _bottombarindex = value;
                  });
                },
                items: [


                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), title: Text('Test')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), title: Text('Test')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.close), title: Text('Sign Out')),
                ],
              ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                  indicatorColor: KMaincolor,
                  onTap: (value) {
                    setState(() {
                      _tabbarindex = value;
                    });
                  },
                  tabs: [
                    Text(
                      'Jackets',
                      style: TextStyle(
                        color:
                        _tabbarindex == 0 ? Colors.black : KUnActiveColor,
                        fontSize: _tabbarindex == 0 ? 16 : null,
                      ),
                    ),
                    Text(
                      'Trousers',
                      style: TextStyle(
                        color:
                        _tabbarindex == 1 ? Colors.black : KUnActiveColor,
                        fontSize: _tabbarindex == 1 ? 16 : null,
                      ),
                    ),
                    Text(
                      'T-Shirts',
                      style: TextStyle(
                        color:
                        _tabbarindex == 2 ? Colors.black : KUnActiveColor,
                        fontSize: _tabbarindex == 2 ? 16 : null,
                      ),
                    ),
                    Text(
                      'Shoes',
                      style: TextStyle(
                        color:
                        _tabbarindex == 3 ? Colors.black : KUnActiveColor,
                        fontSize: _tabbarindex == 3 ? 16 : null,
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  jacketView(),

                  // trouserView(),
                  //    trouserView(),
                  //    trouserView(),
                  //     jacketView(kTshirts),
                  //     jacketView(kShoes),
                  // trouserView(),
                  productView(kTrousers,_products),
                  //     trouserView(),
                    productView(kTshirts,_products),
                    productView(kShoes,_products),
                  // Text('Test'),
                  //
                  // Text('Test'),
                  // Text('Test'),
                ],
              )),
        ),
        Material(
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.shopping_cart,
                    ),onTap: (){
                      Navigator.pushNamed(context, CartScreen.id);
                  },
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
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
            _products = [...products];
            products.clear();
            products = getProductsByCategory(kJackets,_products);


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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
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
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }




}