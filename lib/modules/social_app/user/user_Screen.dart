import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/social_app/cubit.dart';
import 'package:myapp/layout/social_app/states.dart';
import 'package:myapp/models/social_app/user_model.dart';
import 'package:myapp/modules/social_app/user/user_profile.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/styles/colors.dart';

class UserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
      },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildUsers(SocialCubit.get(context).users[index],context),
                separatorBuilder: (context, index) => SizedBox(height: 20,),
                itemCount: SocialCubit.get(context).users.length
            ),
          );
        },
    );
  }
  Widget buildUsers(SocialUserModel user,context) => InkWell(
    onTap: (){
      SocialCubit.get(context).getUserFollowers(uId: user.uId);
      SocialCubit.get(context).getUserFollowing(uId: user.uId,);
      SocialCubit.get(context).getUserPosts(uId: user.uId);
      navigateTo(context, userProfile(user,));
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: defaultColor,
          backgroundImage: NetworkImage('${user.profile}',),
        ),
        SizedBox(
          width: 10,
        ),
        Text('${user.name}',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w700
          ),),
        Spacer(),
        MaterialButton(
          color: user.colorFollowButton,
          minWidth: 1,
          onPressed: (){
            SocialCubit.get(context).followers(uId: user.uId,user: user);
          },
          child: Text('${user.textFollow}',style: TextStyle(color: user.colorFollowText),),
        )
      ],
    ),
  );
}
