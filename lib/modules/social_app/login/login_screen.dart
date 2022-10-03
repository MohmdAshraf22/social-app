import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myapp/layout/social_app/social_layout.dart';
import 'package:myapp/modules/social_app/login/cubit_login.dart';
import 'package:myapp/modules/social_app/login/states_login.dart';
import 'package:myapp/modules/social_app/news_feed/feed_screen.dart';
import 'package:myapp/modules/social_app/social_regiser/register_screen.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/components/constants.dart';
import 'package:myapp/shared/network/local/cache_helper.dart';
import 'package:myapp/shared/styles/colors.dart';


class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var pass = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) =>SocialCubitLogin() ,
      child: BlocConsumer<SocialCubitLogin,SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialErrorLoginState) {
            showToast(text: state.error, state: ToastColor.ERROR);
          }
          if(state is SocialSuccessLoginState)
            {
              CacheHelper.saveData(
                  key: 'uId',
                  value: state.uId,
              ).then((value) {
                uId = CacheHelper.getData(key: 'uId');
                navigateAndFinish(context, SocialLayout());
              });
            }
        },
        builder: (context, state) {
          var cubit = SocialCubitLogin.get(context);
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('SIGN IN'
                                , style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 36,
                                  color: Colors.white
                                ),),
                              SizedBox(
                                height: 20 ,
                              ),
                              Text('Login now to communicate with friends',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              SizedBox(height: 30,),
                              defaultformfield(
                                iconColor: defaultColor,
                                textColor: Colors.black,
                                validate: (value){
                                  if(value!.isEmpty)
                                  {
                                    return'email is empty';
                                  }
                                } ,
                                controle: email,
                                label: 'Enter Your Email',
                                prefix: Icons.email,
                              ),
                              SizedBox(height: 15 ,),
                              TextFormField(
                                validator: (value){
                                  if(value!.isEmpty)
                                  {
                                    return'pass is empty';
                                  }
                                } ,
                                controller: pass,
                                cursorColor: defaultColor,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: cubit.ispass ,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular (30),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular (30),
                                      borderSide: BorderSide(
                                          color: defaultColor,
                                          width: 3
                                      )
                                  ),
                                  labelText: 'Enter Your Password',
                                  labelStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: defaultColor,
                                  ),
                                  suffixIcon: IconButton(
                                    icon : Icon(
                                      cubit.icon,
                                      color: defaultColor,
                                    ),
                                    onPressed: (){
                                      cubit.changePass();
                                    },
                                  ),
                                ),
                              ),

                              SizedBox(height: 15 ,),
                              ConditionalBuilder(
                                condition: state is! SocialLoadingLoginState,
                                builder: (context) => Container(
                                  decoration: BoxDecoration(
                                      color: defaultColor,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  height: 35,
                                  width: double.infinity,
                                  child : MaterialButton(
                                    onPressed: (){
                                      if(formKey.currentState!.validate()){
                                        cubit.userLogin(
                                            email: email.text,
                                            password: pass.text
                                        );
                                      }
                                    },
                                    child: Text('LOGIN',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17
                                      ),),
                                  ),
                                ) ,
                                fallback:(context) => Center(child: CircularProgressIndicator(
                                  color: defaultColor,
                                )) ,
                              ),
                              SizedBox(height: 10 ,),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Don\'t Have Account ?',
                                      style: TextStyle(
                                        fontSize: 17 ,
                                        fontWeight: FontWeight.w600,
                                      ),),
                                    TextButton(
                                        onPressed: (){
                                          navigateTo(context, SocialRegister());
                                        },
                                        child: Text('Register Now',
                                          style: TextStyle(
                                            color: defaultColor,
                                          ),)),
                                  ]
                              )
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
      ),
    );
  }
}
