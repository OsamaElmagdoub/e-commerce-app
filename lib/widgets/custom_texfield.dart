import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String hint ;
  final IconData icon;
  final Function onclick;
 String  _errormessage(String str){

   switch(hint){
     case 'Enter your name': return ' name is empty ';
     case 'Enter your email': return 'email is empty';
     case 'Enter your password': return 'password is empty';
   }
 }
  CustomTextField(
      @required this.hint,
      @required this.icon,
      {this.onclick}
      );
  @override
  Widget build(BuildContext context) {
    return     TextFormField(
      onSaved: onclick,
validator: (value){

  if(value.isEmpty){
    return _errormessage(hint);


  }

},
        cursorColor: KSecondColor,



        decoration:InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon,color: KMaincolor,),

            filled: true,

            fillColor: KSecondColor,
border:OutlineInputBorder(



    borderRadius: BorderRadius.circular(15)



)
            ,
            focusedBorder: OutlineInputBorder(



                borderRadius: BorderRadius.circular(15),

                borderSide: BorderSide(

                    color: Colors.white

                )



            ),

            enabledBorder:OutlineInputBorder(



                borderRadius: BorderRadius.circular(15)



            )



        )

    );
  }
}
