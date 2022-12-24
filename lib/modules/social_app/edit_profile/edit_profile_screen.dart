import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/layout/social_app/cubit.dart';
import 'package:myapp/layout/social_app/states.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var newPass = TextEditingController();
  var currentPass = TextEditingController();
  var newEmail = TextEditingController();
  var formKey = GlobalKey<FormState>();

  ThemeData base = ThemeData();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;

        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;
       // newEmail.text = FirebaseAuth.instance.currentUser!.email!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
            titleSpacing: 5,
            actions: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                 (Set<MaterialState> states) {
                   if (states.contains(MaterialState.pressed))
                     return Colors.grey[300];
                 }
                ),
              ),
                onPressed: (){
                 SocialCubit.get(context).updateUser(
                     name: nameController.text,
                     phone: phoneController.text,
                     bio: bioController.text,
                   context: context,
                 );
                },

                child: Text('UPDATE',
                  style: TextStyle(
                      color: defaultColor,
                      fontSize: 15
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                     if(state is SocialUpdateUserLoadingState)
                    LinearProgressIndicator(
                      color: defaultColor,
                      backgroundColor: HexColor('#F6DDCC') ,
                    ),
                     if(state is SocialUpdateUserLoadingState)
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        if(profileImage != null )
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: defaultColor,
                            backgroundImage: FileImage(profileImage),
                          ),
                        ),
                        if(profileImage == null )
                          Center(
                          child: CircleAvatar(
                            radius: 50,
                              backgroundColor: defaultColor,
                              backgroundImage: NetworkImage('${userModel.profile}')
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.grey[300]; //<-- SEE HERE
                                return null; // Defer to the widget's default.
                              },
                            ),
                          ),
                            onPressed: (){
                            SocialCubit.get(context).getImage();
                            },
                            child: Text('Change profile photo',
                            style: TextStyle(
                              color: defaultColor,
                            ),))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultformfield(
                      iconColor: defaultColor,
                        textColor: defaultColor,
                        controle: nameController,
                        label: 'name',
                        prefix: Icons.person,
                      validate: (value){
                          if(value == null )
                            {
                              return 'Name must not be emtpy';
                            }
                      }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultformfield(
                        iconColor: defaultColor,
                        textColor: defaultColor,
                        controle: bioController,
                        label: 'bio',
                        prefix: Icons.info_outline,
                        validate: (value){
                          if(value == null )
                          {
                            return 'Bio must not be emtpy !';
                          }
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultformfield(
                        iconColor: defaultColor,
                        textColor: defaultColor,
                        controle: phoneController,
                        label: 'phone',
                        prefix: Icons.phone,
                        validate: (value){
                          if(value == null )
                          {
                            return 'Phone must not be emtpy';
                          }
                        }
                    ),
                    SizedBox(

                      height: 20,
                    ),

                    defaultformfield(
                        iconColor: defaultColor,
                        textColor: Colors.black,
                        controle: currentPass,
                        label: 'Current Password',
                        prefix: Icons.lock,
                        validate: (value){
                          if(value == null )
                          {
                            return 'Phone must not be emtpy';
                          }
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    defaultformfield(
                        iconColor: defaultColor,
                        textColor: Colors.black,
                        controle: newPass,
                        label: 'New Password',
                        prefix: Icons.lock,
                        validate: (value){
                          if(value == null )
                          {
                            return 'Phone must not be emtpy';
                          }
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                        onPressed: (){
                          if(formKey.currentState!.validate())
                          {
                            SocialCubit.get(context).changePassword(context,currentPass.text,newPass.text);
                          }
                          },
                        height: 40,
                        minWidth: double.infinity,
                        child: Text('Change Password',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        color: defaultColor
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
