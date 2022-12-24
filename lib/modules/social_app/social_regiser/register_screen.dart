import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myapp/layout/social_app/social_layout.dart';
import 'package:myapp/modules/social_app/social_regiser/cubit.dart';
import 'package:myapp/modules/social_app/social_regiser/register_screen_2.dart';
import 'package:myapp/modules/social_app/social_regiser/states.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/network/local/cache_helper.dart';
import 'package:myapp/shared/styles/colors.dart';


class SocialRegister extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailctrl = TextEditingController();
  var passctrl= TextEditingController();
  var namectrl= TextEditingController();
  var phonectrl= TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubitRegister,SocialRegisterStates>(
      listener: (context, state) {
        if(state is SocialSuccessCreateUserState)
          {
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId).then((value) {
              navigateTo(context, SocialLayout());
            });
          }
      },
      builder: (context, state) {
        var cubit = SocialCubitRegister.get(context);
        return Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      HexColor('#DC7633'),
                      HexColor('#D35400'),
                      HexColor('#A04000'),
                      HexColor('#873600'),
                    ]
                )
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Container(
                     height: 300,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 15),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text('SIGN UP'
                             , style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 36,
                               color: Colors.white,
                             ),),
                           SizedBox(
                             height: 10 ,
                           ),
                           Text('Register now to communicate with friends',
                             style: TextStyle(
                                 fontSize: 17,
                               color: Colors.white,
                             ),),
                         ],
                        ),
                     ),
                   ),
                   Container(
                     decoration: BoxDecoration(

                         color: Colors.white,
                         borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                     ),
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 15),
                       child: Column(
                         children: [
                           SizedBox(height: 30,),
                           TextFormField(
                             validator: (value){
                               if(value!.isEmpty)
                               {
                                 return'Name is empty';
                               }
                             } ,
                             controller: namectrl ,
                             keyboardType: TextInputType.name,
                             cursorColor: defaultColor,
                             decoration: InputDecoration(
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: defaultColor,
                                   width: 3,
                                 ),
                                 borderRadius: BorderRadius.circular(30),
                               ),
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(30),
                               ),
                               labelText: 'User Name',
                               labelStyle: TextStyle(color: Colors.black),
                               prefixIcon: Icon(
                                 Icons.person,
                                 color: defaultColor,

                               ),
                             ),
                           ),//// name
                           SizedBox(height: 15 ,),
                           TextFormField(
                             validator: (value){
                               if(value!.isEmpty)
                               {
                                 return'Email is empty';
                               }
                             } ,
                             controller: emailctrl,
                             keyboardType: TextInputType.emailAddress,
                             cursorColor: defaultColor,
                             decoration: InputDecoration(
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: defaultColor,
                                   width: 3,
                                 ),
                                 borderRadius: BorderRadius.circular(30),

                               ),
                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular (30),
                               ),
                               labelText: 'Your Email Address',
                               labelStyle: TextStyle(color: Colors.black),

                               prefixIcon: Icon(
                                 Icons.email,
                                 color: defaultColor,
                               ),
                             ),
                           ),//// email
                           SizedBox(height: 15 ,),
                           TextFormField(
                             validator: (value){
                               if(value!.isEmpty)
                               {
                                 return'Phone is empty';
                               }
                             } ,
                             controller: phonectrl,
                             keyboardType: TextInputType.phone,
                             cursorColor: defaultColor,
                             decoration: InputDecoration(
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: defaultColor,
                                   width: 3,
                                 ),
                                 borderRadius: BorderRadius.circular(30),
                               ),
                               border: OutlineInputBorder(
                                 borderSide: BorderSide(
                                     width: 3,
                                     color: defaultColor
                                 ),
                                 borderRadius: BorderRadius.circular (30),
                               ),
                               labelText: 'Your Phone',
                               labelStyle: TextStyle(color: Colors.black),

                               prefixIcon: Icon(
                                 Icons.phone,
                                 color: defaultColor,
                               ),
                             ),
                           ),//// phone
                           SizedBox(height: 15 ,),
                           TextFormField(
                             validator: (value){
                               if(value!.isEmpty)
                               {
                                 return'Pass is empty';
                               }
                             } ,
                             controller: passctrl,
                             keyboardType: TextInputType.visiblePassword,
                             obscureText: cubit.ispass ,
                             cursorColor: defaultColor,
                             decoration: InputDecoration(
                               border: OutlineInputBorder(
                                 borderSide: BorderSide(
                                     width: 2,
                                     color: defaultColor
                                 ),
                                 borderRadius: BorderRadius.circular (30),
                               ),
                               focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: defaultColor,
                                   width: 3,
                                 ),
                                 borderRadius: BorderRadius.circular(30),

                               ),
                               labelText: 'Your Password',
                               labelStyle: TextStyle(color: Colors.black),

                               prefixIcon: Icon(
                                 Icons.lock,
                                 color: defaultColor,
                               ),
                               suffixIcon:IconButton(
                                 icon : Icon(
                                   cubit.icon,
                                   color: defaultColor,
                                 ),
                                 onPressed: (){
                                   cubit.changePass();
                                 },
                               ),
                             ),
                           ),//// pass
                           SizedBox(height: 15 ,),
                           Row(
                             children: [
                               Spacer(),
                               ConditionalBuilder(
                                 condition: state is! SocialLoadingRegisterState,
                                 builder: (context) => MaterialButton(
                                   elevation: 8,
                                   color: defaultColor,
                                   onPressed: ()async{
                                     if(formKey.currentState!.validate()){
                                       await cubit.userRegister(email: emailctrl.text, password: passctrl.text);
                                       navigateTo(context, RegisterScreen2(namectrl,phonectrl,emailctrl));
                                     }
                                   },
                                   child: Text('Next',
                                     style: TextStyle(
                                         color: Colors.white,
                                         fontSize: 17
                                     ),),
                                 ) ,
                                 fallback:(context) => Center(child: CircularProgressIndicator(
                                   color: defaultColor,
                                 )) ,
                               ),
                             ],
                           ),
                         ],
                       ),
                     ),
                   ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
