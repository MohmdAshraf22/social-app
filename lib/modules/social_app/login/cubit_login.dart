import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/modules/social_app/login/states_login.dart';



class SocialCubitLogin extends Cubit<SocialLoginStates>
{
  SocialCubitLogin() : super(SocialInitialLoginState());

  static SocialCubitLogin get(context) => BlocProvider.of(context);
  bool ispass = true;
  IconData icon = Icons.visibility;


  void changePass() {

    if (ispass == false) {
      ispass = true;
      icon = Icons.visibility;
    }

    else {
      ispass = false;
      icon = Icons.visibility_off;
    }
    emit(SocialChangePassState());
  }
  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(SocialLoadingLoginState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password
    ).then((value) {
      emit(SocialSuccessLoginState(value.user!.uid));
    }).catchError((error){
      print(password);
      emit(SocialErrorLoginState(error.toString()));
    });
  }

  bool isLoading = true;
  void circleProgress()
  {
    isLoading = !isLoading;
  }
}