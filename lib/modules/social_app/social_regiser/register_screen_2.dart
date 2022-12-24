import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';
import 'package:myapp/modules/social_app/social_regiser/cubit.dart';
import 'package:myapp/modules/social_app/social_regiser/states.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/styles/colors.dart';

class RegisterScreen2 extends StatelessWidget {

  //var passctrl= TextEditingController();
  var namectrl= TextEditingController();
  var emailctrl= TextEditingController();
  var phonectrl= TextEditingController();
  var bio = TextEditingController();
  RegisterScreen2(
      this.namectrl,
      this.phonectrl,
      this.emailctrl,
      );
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubitRegister,SocialRegisterStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var profileImage =SocialCubitRegister.get(context).profileImage;

        return  Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(profileImage != null)
                  Center(
                    child: CircleAvatar(
                      radius: 133,
                      backgroundColor: HexColor('#FDF2E9'),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 130,
                            backgroundColor: HexColor('#FBFCFC'),
                            child: CircleAvatar(
                              radius: 97,
                              backgroundColor: HexColor('#EDBB99'),
                              child: CircleAvatar(
                                radius: 95,
                                backgroundColor: HexColor('#FDFEFE'),
                                child: CircleAvatar(
                                  radius: 67,
                                  backgroundColor: HexColor('#E59866'),
                                  child: CircleAvatar(
                                    radius: 65,
                                    backgroundColor: HexColor('#FDF2E9'),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: defaultColor,
                                      backgroundImage: FileImage(profileImage),
                                  ),
                                ),
                              ),

                            ),
                          ),
                         ),
                          IconButton(
                              onPressed: (){
                                SocialCubitRegister.get(context).getImage();
                              },
                              icon: Icon(
                                IconlyBroken.camera,
                                color: defaultColor,)
                          )
                        ],
                      ),
                    ),
                  ),
                  if(profileImage == null)
                    Center(
                    child: CircleAvatar(
                      radius: 132,
                      backgroundColor: HexColor('#FDF2E9'),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 130,
                            backgroundColor: HexColor('#FBFCFC'),
                            child: CircleAvatar(
                              radius: 97,
                              backgroundColor: HexColor('#EDBB99'),
                              child: CircleAvatar(
                                radius: 95,
                                backgroundColor: HexColor('#FDFEFE'),
                                child: CircleAvatar(
                                  radius: 67,
                                  backgroundColor: HexColor('#E59866'),
                                  child: CircleAvatar(
                                    radius: 65,
                                    backgroundColor: HexColor('#FDF2E9'),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: defaultColor,
                                      backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIOMcVIkR9uQwKms9V--fyN8d8svTGbvByBw&usqp=CAU'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                         ),
                          IconButton(
                              onPressed: (){
                                SocialCubitRegister.get(context).getImage();
                              },
                              icon: Icon(
                                IconlyBroken.camera,
                                color: defaultColor,)
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  defaultformfield(
                    iconColor: defaultColor,
                    textColor: Colors.black,
                    controle: bio,
                    label: 'Add Bio',
                    prefix: Icons.info_outline,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: ()async{
                      // if (profileImage != null) {
                     await SocialCubitRegister.get(context).uploadProfile();
                      //}
                      SocialCubitRegister.get(context).userCreate(
                        email: emailctrl.text,
                          name: namectrl.text,
                          phone: phonectrl.text,
                        bio: bio.text,
                      );
                    },
                    elevation: 7,
                    minWidth: double.infinity,
                    color: defaultColor,
                    child: Text('Sign up',style: TextStyle(
                        color: Colors.white
                    ),),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
