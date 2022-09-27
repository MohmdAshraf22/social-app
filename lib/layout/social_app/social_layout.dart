import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:myapp/layout/shop_app/cubit_shop.dart';
import 'package:myapp/layout/social_app/cubit.dart';
import 'package:myapp/layout/social_app/states.dart';
import 'package:myapp/modules/social_app/create_post/create_post_screen.dart';
import 'package:myapp/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:myapp/modules/social_app/social_regiser/cubit.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/styles/colors.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SocialCubit.get(context).getPosts();

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
        if(state is SocialPostState)
          navigateTo(context, CreatePost());
      },
      builder:(context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: defaultColor,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: defaultColor,
                        backgroundImage: NetworkImage('${ SocialCubit.get(context).userModel!.profile}'),
                      ),
                      SizedBox(height: 10,),
                      Text('${SocialCubit.get(context).userModel!.email}',style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      ),)
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.edit,
                  ),
                  title: Text('Edit Profile'),
                  onTap: () {
                    navigateTo(context, EditProfileScreen());
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: Text('Log out'),
                  onTap: () {
                    SocialCubit.get(context).current = 0;
                    SocialCubit.get(context).showSimpleDialogLogout(context);
                  },
                ),
              ],
            ),
          ),

          appBar: AppBar(
            title: Text(cubit.titles[cubit.current]),
            actions: [
              IconButton(
                onPressed: (){},
                icon: Icon(
                IconlyBroken.notification,
              ),),
              IconButton(
                onPressed: (){},
                icon: Icon(
                IconlyBroken.search,
              ),),
            ],
          ),
          body: cubit.screens[cubit.current],
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: cubit.current,
            onTap: (index){
              cubit.ChangeBottom(index);
            },
              selectedItemColor: defaultColor,
              curve: Curves.linearToEaseOut,
              items: [
                SalomonBottomBarItem(icon: Icon( IconlyBroken.home), title: Text('Home') ,),
                SalomonBottomBarItem(icon: Icon( IconlyBroken.chat), title: Text('Chats') ),
                SalomonBottomBarItem(icon: Icon( IconlyBroken.paper_plus,), title: Text('Add') ),
                SalomonBottomBarItem(icon: Icon( IconlyBroken.info_square), title: Text('User') ),
                SalomonBottomBarItem(icon: Icon( Icons.person,), title: Text('Profile') ),
              ]),
        );
      },
    );
  }
}
