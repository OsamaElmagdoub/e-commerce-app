import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/models/product.dart';

class Store{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  addproduct(Product product){
_firestore.collection(KProductsCollectionPath).add({
kProductName:product.pName,
  kProductCategory:product.pCategory,
  kProductDescription:product.pDescription,
  kProductPrice:product.pPrice,
  KProductLocation:product.pLocation,

});

  }

  Stream<QuerySnapshot> loadProducts() {
//   List<Product> products=[];
return
  _firestore.collection(KProductsCollectionPath).snapshots();

    //){
   // print(snapshot.docs);

  // for(var doc in snapshot.docs) {
  //   var data = doc.data();
  //
  //   products.add(Product(
  //
  //     pName: data[kProductName],
  //     pLocation: data[KProductLocation],
  //     pCategory: data[kProductCategory],
  //     pDescription: data[kProductDescription],
  //     pPrice: data[kProductPrice],
  //
  //   ));
  // }

}

  deleteProduct(documentId){

    _firestore.collection(KProductsCollectionPath).doc(documentId).delete();
  }

  editProduct(
data     , documentId
      ){
    _firestore.collection(KProductsCollectionPath).doc(documentId).update(data);

  }
  Stream<QuerySnapshot>loadOrders(){

 return   _firestore.collection(kOrders).snapshots();
  }
  Stream<QuerySnapshot>loadOrderDetails(documentId){

    return   _firestore.collection(kOrders).doc(documentId).collection(kOrderDetails).snapshots();
  }
  storeOrders(data,List<Product>products){

  var documentRef=  _firestore.collection(kOrders).doc();
  documentRef.set(data);
  for(var product in products) {
    documentRef.collection(kOrderDetails).doc().set({

      kProductName:product.pName,
      kProductPrice :product.pPrice,
      kProductQuantity :product.pQuantity,
      KProductLocation : product.pLocation,
      kProductCategory:product.pCategory,
    });
  }}
  }



//}