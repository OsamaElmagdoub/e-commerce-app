import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/services/store.dart';
import 'package:flutter/material.dart';
class OrderDetails extends StatelessWidget {
static String id = 'OrderDetails';
final Store _store = Store();

  @override
  Widget build(BuildContext context) {
    String documentId= ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(

          stream:_store.loadOrderDetails(documentId)
          ,builder:(context,snapshot){
            if(snapshot.hasData){
    List<Product> products=[];


              for(var document in snapshot.data.docs){

                products.add(Product(
                  pName: document.data()[kProductName],
                  pPrice: document.data()[kProductPrice],
                  pCategory: document.data()[kProductCategory]
                ));
              }


              return
                Column(children: [
                Expanded(
                  child: ListView.builder(
                  itemCount: products.length,
                    itemBuilder: (context,index)=>
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.2,
                            color: KMaincolor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text("${products[index].pName}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  Text(
                                    '${products[index].pPrice}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                                  ,                 Text("${products[index].pCategory}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)

                                ],
                              ),
                            ),
                          ),
                        ),
                  ),
                ) ,Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
Expanded(child:   ElevatedButton(onPressed: (){}, child: Text('Confirm Order'),
),),
                  SizedBox(width: 20,),
                  Expanded(child:  ElevatedButton(onPressed: (){}, child: Text('Delete Order'))),

                    ],),
                )
                ],);

            }else{return Text('Try loading orders');}

      } ),
    );
  }
}
