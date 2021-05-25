import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/provider/cratItem.dart';
import 'package:ecommerce/screens/user/productInfo.dart';
import 'package:ecommerce/services/store.dart';
import 'package:ecommerce/widgets/custom-menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static String id = 'cartScreen';
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appbarHeight=AppBar().preferredSize.height;
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    List<Product> products = Provider.of<CartItem>(context).products;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'My Cart',
            style: TextStyle(color: Colors.black),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Column(children: [
          LayoutBuilder(builder: (context, constraints) {
            if (products.isNotEmpty) {
              return Container(
                height: screenHeight-(screenHeight*0.08)- statusbarHeight-appbarHeight,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTapUp: (details) {
                          showCustomMenu(context,details,products[index]);
                        },
                        child: Container(
                          width: screenWidth,
                          height: screenHeight * 0.13,
                          color: KMaincolor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: screenHeight * 0.13 / 2,
                                  backgroundImage:
                                      AssetImage(products[index].pLocation),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          children: [
                                            Text(
                                              products[index].pName,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '\$${products[index].pPrice}',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: Text(
                                          products[index].pQuantity.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: products.length,
                ),
              );
            } else {
              return Container(
                height: screenHeight-(screenHeight*0.08)- statusbarHeight-appbarHeight,
                child: Center(
                    child: Text(
                  'Cart is Empty',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                )),
              );
            }
          }),
          Builder(builder:(context)=>
             SizedBox(
              width: screenWidth,
              height: screenHeight * 0.08,
              child: ElevatedButton(
                  onPressed: () {

                    showCustomdialoge(products,context);

                  },
                  child: Text(
                    'order'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ),
          )
        ]));
  }

  void showCustomMenu(context,details,product)async {
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width - dx;
    double dy2 = MediaQuery.of(context).size.height- dy;
    showMenu(context: context, position:RelativeRect.fromLTRB(dx, dy, dy2, dy2), items: [

        MyPopupMenuItem(
        onclick: (){
Navigator.pop(context);
Provider.of<CartItem>(context,listen: false).deleteProduct(product);
Navigator.pushNamed(context, ProductInfo.id,arguments: product);
    },
    child: Text('Edit'),
    ),
    MyPopupMenuItem(child:Text('Delete'), onclick: (){
      Navigator.pop(context);
      Provider.of<CartItem>(context,listen: false).deleteProduct(product);
    })]);
}

  void showCustomdialoge(List<Product>products,context) async{
 var   price =getTotalPrice(products);
 var address;
    AlertDialog alertDialog =AlertDialog(
      content: TextField(
        onChanged: (value){
          address = value;
        },
        decoration: InputDecoration(hintText: 'Enter Your Address'),
      ),
      
      title: Text('Total Price = \$ $price'),
actions: [
  
  MaterialButton(onPressed: (){
    Store _store = Store();
    try {
      _store.storeOrders({
        kProductPrice: price,
        kAddress:
        address,
      }, products);

      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Ordered Successfully')));
      Navigator.pop(context);
    }catch(ex){
      print(ex);
    }

  },child: Text('Confirm'),)
],
    );
    await showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }

 getTotalPrice(List<Product> products) {
var price = 0;
    for(var product in products){
price += product.pQuantity * int.parse( product.pPrice);

    }return price;

 }
}