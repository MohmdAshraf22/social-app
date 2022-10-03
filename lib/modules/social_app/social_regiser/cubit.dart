import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/models/social_app/user_model.dart';
import 'package:myapp/modules/social_app/social_regiser/states.dart';


class SocialCubitRegister extends Cubit<SocialRegisterStates>
{
  SocialCubitRegister() : super(SocialInitialRegisterState());

  static SocialCubitRegister get(context) => BlocProvider.of(context);
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
    emit(SocialChangePassRegisterState());
  }

  SocialUserModel? userModel;
  String profile = '';
  Future uploadProfile() async
  {
    Reference ref = firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}');

    await ref.putFile(profileImage!);
    await ref.getDownloadURL().then((value) {
      profile = value ;
      print(profile);
      emit(SocialUploadProfileRegisterSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialUploadProfileRegisterErrorState());
    });
  }
String? uid;
  Future userRegister({
   required String email,
   required String password,
})async
  {
    emit(SocialLoadingRegisterState());

   FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email, password: password)
       .then((value) {
         uid = value.user!.uid;
         emit(SocialSuccessRegisterState());
   }).catchError((error){
     print(error.toString());
     emit(SocialErrorRegisterState(error.toString()));
   });
  }

  File? profileImage;
  final picker = ImagePicker();
  Future<void> getImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(SocialAddProfileRegisterSuccessState());
    }
    else
    {
      print('No image selected !!');
      emit(SocialAddProfileRegisterErrorState());
    }
  }



  Future userCreate({
    required String name,
    required String phone,
    required String email,
    String? bio,
})async
  {

    emit(SocialLoadingCreateUserState());
    SocialUserModel? model = SocialUserModel(
      uId: uid,
      phone: phone,
      name: name,
      email: email,
      isEmailVerified: false,
      profile: profile,
      bio: bio??'write your bio...',
    );
   FirebaseFirestore.instance.collection('users')
       .doc(uid)
       .set(model.toMap())
       .then((value) {
         emit(SocialSuccessCreateUserState(uid!));
   }).catchError((error){
     print(error.toString());
     emit(SocialErrorCreateUserState(error.toString()));
   });
  }

}