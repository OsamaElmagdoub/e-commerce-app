
import 'package:ecommerce/models/product.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier{

  List<Product>products = [];
  add(Product product){

    products.add(product);
    notifyListeners();

  }
  deleteProduct(Product product){
    products.remove(product);
    notifyListeners();

  }

}