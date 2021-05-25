import 'package:ecommerce/constants.dart';
import 'package:ecommerce/provider/adminMode.dart';
import 'package:ecommerce/provider/modal_hud.dart';
import 'package:ecommerce/screens/admin/adminHome.dart';
import 'package:ecommerce/screens/user/homePage.dart';
import 'package:ecommerce/screens/user/signup_screen.dart';
import 'file:///F:/Courses/Flutter/flutter_projects/New/ecommerce/lib/widgets/custom_texfield.dart';

import 'package:ecommerce/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginscreen';
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String _email, _password;

  bool isAdmin = false;

  final _auth = Auth();

  final adminPassword = 'admin1234';

  bool keepMeLoggedIn= false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(

      backgroundColor: KMaincolor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: widget._globalkey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('images/icons/buy1.png')),
                    Text(
                      'Buy it',
                      style: TextStyle(fontFamily: 'Pacifico'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomTextField(
                'Enter your email',
                Icons.email,
                onclick: (value) {
                  _email = value;
                },
              ),
              Row(children: [
                Checkbox(

                  checkColor: Colors.white,
                  activeColor: Colors.black,
                  value: keepMeLoggedIn,
                  onChanged: (value){
                  setState(() {
                    keepMeLoggedIn= value;
                  });

                },),
                Text('Remember me')
              ],),
              CustomTextField(
                'Enter your password',
                Icons.lock,
                onclick: (value) {
                  _password = value;
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                      onPressed: () {
                        if(keepMeLoggedIn==true){
                          keepUserLoggedIn();

                        }
                        _validate(context);

                        // final modalhud =
                        //     Provider.of<ModalHud>(context, listen: false);
                        // modalhud.changeinloading(true);
                        // if (_globalkey.currentState.validate()) {
                        //   try {
                        //     _globalkey.currentState.save();
                        //     final result =
                        //         await _auth.signIn(_email, _password);
                        //     print(result.user.uid);
                        //   } catch (e) {
                        //     modalhud.changeinloading(false);
                        //     Scaffold.of(context).showSnackBar(
                        //         SnackBar(content: Text(e.message)));
                        //   }
                        // }
                        // modalhud.changeinloading(false);
                      },
                      child: Text('Sign in')),
                ),
              ),
              SizedBox(
                height: height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text('Sign up',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeisAdmin(true);
                      },
                      child: Text(
                        "I'm an admin ",
                        style: TextStyle(
                            fontSize: 20,
                            color: Provider.of<AdminMode>(
                              context,
                            ).isAdmin
                                ? KMaincolor
                                : Colors.white),
                      )),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  GestureDetector(
                      onTap: () {
                        Provider.of<AdminMode>(context, listen: false)
                            .changeisAdmin(false);
                      },
                      child: Text(
                        "I'm a user ",
                        style: TextStyle(
                            fontSize: 20,
                            color: Provider.of<AdminMode>(
                              context,
                            ).isAdmin
                                ? Colors.white
                                : KMaincolor),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async{
    final modalhud = Provider.of<ModalHud>(context,listen: false);
    modalhud.changeinloading(true);
    if (widget._globalkey.currentState.validate()) {
      widget._globalkey.currentState.save();
      if (Provider.of<AdminMode>(context,listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
        await    _auth.signIn(_email, _password);
            Navigator.of(context).pushNamed(AdminHome.id);
          } catch (e) {
            modalhud.changeinloading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } else {
          modalhud.changeinloading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong'),
          ));
        }
      } else {
        try {
        await  _auth.signIn(_email, _password);
          Navigator.of(context).pushNamed(HomePage.id);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modalhud.changeinloading(false);
  }

  void keepUserLoggedIn()async {
    SharedPreferences preferences =await SharedPreferences.getInstance();
preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
