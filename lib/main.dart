
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/provider/adminMode.dart';
import 'package:ecommerce/provider/cratItem.dart';
import 'package:ecommerce/provider/modal_hud.dart';
import 'package:ecommerce/screens/admin/OrderDetails.dart';
import 'package:ecommerce/screens/admin/OrdersScreen.dart';
import 'package:ecommerce/screens/admin/addProduct.dart';
import 'package:ecommerce/screens/admin/adminHome.dart';
import 'package:ecommerce/screens/admin/cartScreen.dart';
import 'package:ecommerce/screens/admin/editProduct.dart';
import 'package:ecommerce/screens/admin/manageProduct.dart';
import 'package:ecommerce/screens/user/homePage.dart';
import 'package:ecommerce/screens/user/login_screen.dart';
import 'package:ecommerce/screens/user/productInfo.dart';
import 'package:ecommerce/screens/user/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  bool isUserLoggedIn= false;
  @override


  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(

        future: SharedPreferences.getInstance(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return MaterialApp(home: Scaffold(body: Center(child: Text('Loading ...'),),),);

          }else{

isUserLoggedIn=snapshot.data.getBool(kKeepMeLoggedIn) ?? false;
            return MultiProvider(providers: [

              ChangeNotifierProvider<ModalHud>(create: (context)=>ModalHud(),

              ),
              ChangeNotifierProvider<AdminMode>(create: (context)=>AdminMode()),
              ChangeNotifierProvider<CartItem>(create: (context)=>CartItem(),

              ),


            ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute:isUserLoggedIn?HomePage.id: LoginScreen.id,
                routes: {
                  OrderDetails.id:(context)=>OrderDetails(),
                  OrdersScreen.id:(context)=>OrdersScreen(),
                  ProductInfo.id:(context)=>ProductInfo(),
                  LoginScreen.id:(context)=>LoginScreen(),
                  SignUpScreen.id:(context)=>SignUpScreen(),
                  HomePage.id:(context)=>HomePage(),
                  AdminHome.id:(context)=>AdminHome(),
                  AddProduct.id:(context)=>AddProduct(),
                  ManageProduct.id:(context)=>ManageProduct(),
                  EditProduct.id:(context)=>EditProduct(),
                  CartScreen.id:(context)=>CartScreen(),
                },
              ),
            );
          }


        });


  }
}
