import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/order.dart';
import 'package:ecommerce/screens/admin/OrderDetails.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/material.dart';
class OrdersScreen extends StatelessWidget {

static String id = 'ordersScreen';
final Store _store=Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: Text('There is no orders'),);

          }else{
            List<Order>orders = [];
            for(var doc in snapshot.data.docs){

orders.add(Order(
  documentId: doc.id,
  address: doc.data()[kAddress],
totalPrice: doc.data()[kTotalPrice],
));
            }
            return Center(
              child: ListView.builder(itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, OrderDetails.id,arguments: orders[index].documentId);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      color: KMaincolor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text(orders[index].totalPrice.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            Text(orders[index].address,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },itemCount: orders.length,),
            );
          }

        },
      ),
    );
  }
}
