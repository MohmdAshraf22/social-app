import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';
import 'package:myapp/layout/social_app/cubit.dart';
import 'package:myapp/layout/social_app/states.dart';
import 'package:myapp/models/social_app/chats_model.dart';
import 'package:myapp/models/social_app/user_model.dart';
import 'package:myapp/shared/components/constants.dart';
import 'package:myapp/shared/styles/colors.dart';

class ChatsScreen extends StatelessWidget {
 late SocialUserModel usersModel;
 ChatsScreen(this.usersModel);

 var message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          SocialCubit.get(context).getMessage(hisId:usersModel.uId);
          
          return BlocConsumer<SocialCubit,SocialStates>(
            listener: (context, state) {
            },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0,
                  leadingWidth: 50,
                  title: Row(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
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
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message = SocialCubit.get(context).messages[index];
                              if(uId != message.hisId) {
                                return buildMyMessage(message);
                              }
                              return buildHisMessage(message);
                            } ,
                            separatorBuilder: (context, index) => SizedBox(height: 10,),
                            itemCount: SocialCubit.get(context).messages.length
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  width: 1,
                                  color: HexColor('#D5D8DC'),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8
                                ),
                                child: TextField(
                                  controller: message,
                                  maxLines: 6,
                                  minLines: 1,
                                  cursorColor: defaultColor,
                                  decoration: InputDecoration(
                                      hintText: 'Message',
                                      hintStyle: Theme.of(context).textTheme.caption,
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            onPressed: () {
                              SocialCubit.get(context).sendMessage(
                                  message: message.text,
                                  datetime: DateTime.now().toString(),
                                  hisId: usersModel.uId
                              );
                              message.clear();
                            },
                            color: HexColor('#DC7633'),
                            textColor: Colors.white,
                            child: Icon(
                              IconlyBroken.send,
                              size: 24,
                            ),
                            padding: EdgeInsets.all(13),
                            minWidth: 1,
                            shape: CircleBorder(),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
    );
  }
  Widget buildHisMessage(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 15
        ),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(15),
              bottomStart: Radius.circular(15),
              topEnd: Radius.circular(15),
            )
        ),
        child: Text('${messageModel.message}',
          style: TextStyle(
              fontSize: 18
          ),),
      ),
    );
  }
  Widget buildMyMessage(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 15
        ),
        decoration: BoxDecoration(
            color: HexColor('#EDBB99'),
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(15),
              bottomStart: Radius.circular(15),
              topStart: Radius.circular(15),
            )
        ),
        child: Text('${messageModel.message}',
          style: TextStyle(
              fontSize: 18
          ),),
      ),
    );
  }
}
