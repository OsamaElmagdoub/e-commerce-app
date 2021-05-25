import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/provider/cratItem.dart';
import 'package:ecommerce/screens/admin/cartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image(
                  fit: BoxFit.fill, image: AssetImage(product.pLocation))),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(

                    child: Icon(Icons.arrow_back),onTap: (){

                      Navigator.of(context).pop();
                },),
                GestureDetector(
                  child: Icon(
                    Icons.shopping_cart,
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, CartScreen.id);
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(children: [
              Text(''),
              Opacity(
                opacity: 0.5,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.pName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          product.pDescription,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          '\$  ${product.pPrice}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Material(
                                color: KMaincolor,
                                child: GestureDetector(
                                  onTap: subtract,
                                  child: SizedBox(
                                    child: Icon(Icons.remove),
                                    height: 28,
                                    width: 28,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              _quantity.toString(),
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ClipOval(
                              child: Material(
                                color: KMaincolor,
                                child: GestureDetector(
                                  child: SizedBox(
                                    child: Icon(Icons.add),
                                    height: 28,
                                    width: 28,
                                  ),
                                  onTap: add,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                ),
              ),
              Builder(
                builder: (context) => ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ButtonStyle(

//shape: MaterialStateProperty.all(BorderRadius.circular(20)),
                        backgroundColor: MaterialStateProperty.all(
                            //   BorderRadius.circular(20),
                            KMaincolor)),
                    onPressed: () {
                      addToCart(context,product);

                    },
                    child: Text(
                      'add to cart'.toUpperCase(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
    });
  }

  void addToCart(context,product) {
    CartItem cartItem =
    Provider.of<CartItem>(context, listen: false);
    bool exist = false;
    product.pQuantity = _quantity;
    var productsInCart = cartItem.products;
    for(var productInCart in productsInCart){
      if(productInCart.pName==product.pName){

        exist=true;
      }

    }
if(exist){


  Scaffold.of(context).showSnackBar(
      SnackBar(content: Text('you have added this item  to cart')));
}else{
  cartItem.add(product);
  Scaffold.of(context).showSnackBar(
      SnackBar(content: Text('added to cart')));
}
}
}

