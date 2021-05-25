import 'package:ecommerce/constants.dart';
import 'package:ecommerce/provider/modal_hud.dart';
import 'package:ecommerce/screens/user/login_screen.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_texfield.dart';

class SignUpScreen extends StatelessWidget {
  static String id = 'signupscreen';
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return  Scaffold(
        backgroundColor: KMaincolor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ModalProgressHUD(
            inAsyncCall: Provider.of<ModalHud>(context).isloading,
            child: Form(
              key: _globalkey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
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
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomTextField('Enter your name', Icons.person),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CustomTextField(
                    'Enter your email',
                    Icons.email,
                    onclick: (value) {
                      _email = value;
                    },
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: () async {
                            final modalhud = Provider.of<ModalHud>(context,listen: false);
                            modalhud.changeinloading(true);
                            if (_globalkey.currentState.validate()) {


                              try {
                                _globalkey.currentState.save();
                                print(_email);
                                print(_password);

                                final authresult =
                                    await _auth.signup(_email.trim(), _password.trim());
                                modalhud.changeinloading(false);
                               Navigator.pushNamed(context, LoginScreen.id);
                              }


                              catch (e) {
                                modalhud.changeinloading(false);
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text(e.message)));
                              }

                            }
                            modalhud.changeinloading(false);
                          },
                          child: Text('Sign up')),
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
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text('Login',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );

  }
}
