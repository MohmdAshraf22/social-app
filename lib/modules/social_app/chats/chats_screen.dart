import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/social_app/cubit.dart';
import 'package:myapp/layout/social_app/states.dart';
import 'package:myapp/models/social_app/user_model.dart';
import 'package:myapp/modules/social_app/chats/chats.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/styles/colors.dart';

class Chats extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).users.isNotEmpty,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(SocialCubit.get(context).users[index],context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: SocialCubit.get(context).users.length
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(
              color: defaultColor,
            )),
        );
      },
    );
  }
  Widget buildChatItem(SocialUserModel usersModel,context) {
    return  InkWell(
      onTap: (){
        navigateTo(context, ChatsScreen(usersModel));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 23
              ,
              backgroundColor: defaultColor,
              backgroundImage: NetworkImage('${usersModel.profile}',),
            ),
            SizedBox(
              width: 15,
            ),
            Text('${usersModel.name}',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
