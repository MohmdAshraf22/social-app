import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:myapp/layout/social_app/cubit.dart';
import 'package:myapp/layout/social_app/states.dart';
import 'package:myapp/models/social_app/post_model.dart';
import 'package:myapp/models/social_app/user_model.dart';
import 'package:myapp/modules/social_app/edit_profile/edit_profile_screen.dart';
import 'package:myapp/modules/social_app/login/login_screen.dart';
import 'package:myapp/modules/social_app/news_feed/comments.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/components/constants.dart';
import 'package:myapp/shared/styles/colors.dart';

class SettingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).c = 0 ;
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return SingleChildScrollView(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 132,
                      backgroundColor: HexColor('#FDF2E9'),
                      child: CircleAvatar(
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
                                  backgroundImage: NetworkImage('${userModel!.profile}'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text('${userModel.name}',
                    style: Theme.of(context).textTheme.bodyText1,),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${userModel.bio}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 15
                    ),),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 25,
                    ),
                    child: TabBar(
                      indicatorColor: defaultColor,
                      onTap: (value){
                        SocialCubit.get(context).ChangeTap(value);
                      },
                      tabs: [
                        Tab(
                          child: Column(
                            children: [
                              Text('${SocialCubit.get(context).myPosts.length}',style: Theme.of(context).textTheme.headline6!.copyWith(
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('Posts',
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                    fontSize: 15
                                ),)
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            children: [
                              Text('${SocialCubit.get(context).follower}',style: Theme.of(context).textTheme.headline6!.copyWith(
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('Followers',
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                    fontSize: 15
                                ),)
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            children: [
                              Text('${SocialCubit.get(context).following}',style: Theme.of(context).textTheme.headline6!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),),
                              Text('Following',
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                    fontSize: 15
                                ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(SocialCubit.get(context).c == 0)
                   Padding(
                     padding: EdgeInsets.symmetric(
                         horizontal: 15
                     ),
                     child: ConditionalBuilder(
                     condition: SocialCubit.get(context).myPosts.isNotEmpty,
                     builder: (context) => ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                   return buildPost(SocialCubit.get(context).myPosts[index],context,index,);
                     },
                       separatorBuilder: (context, index) => SizedBox(height: 10,),
                       itemCount: SocialCubit.get(context).myPosts.length,
                     ),
                     fallback: (context) => Center(child: Text('No posts yet',
                       style: TextStyle(fontSize: 30,color: Colors.grey[500]),),),
                   ),
                   ),
                  if(SocialCubit.get(context).c == 1)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15
                      ),

                      child: ConditionalBuilder(
                        condition: SocialCubit.get(context).followersId.isNotEmpty,
                        builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if(SocialCubit.get(context).users[index].follow == true)
                              return buildUsers(SocialCubit.get(context).Followers![index],context);
                            return Container();
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          itemCount: SocialCubit.get(context).Followers!.length,
                        ),
                        fallback: (context) => Center(child: Text('No followers yet',
                          style: TextStyle(fontSize: 30,color: Colors.grey[500]),),),
                      ),
                    ),
                  if(SocialCubit.get(context).c == 2)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15
                      ),

                      child: ConditionalBuilder(
                        condition: SocialCubit.get(context).followingId.isNotEmpty,
                        builder: (context) => ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            print(index);
                            return buildUsers(SocialCubit.get(context).users[index],context);
                            return Container();
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                          itemCount: SocialCubit.get(context).users.length,
                        ),
                        fallback: (context) => Center(child: Text('No following yet',
                          style: TextStyle(fontSize: 30,color: Colors.grey[500]),),),
                      ),
                    ),
                    ]
              ),
            ),
        );
      },
    );
  }
  Widget buildPost(PostModel postModel , context, index) {
    late TextEditingController commentController = TextEditingController();
    var cubit = SocialCubit.get(context);
    // if(uId == postModel.uId) {
    return Card(
      elevation: 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 10
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: defaultColor,
                  backgroundImage: NetworkImage('${postModel.profile}',),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${postModel.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text('${postModel.dateTime}',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert)
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10
            ),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10
            ),
            child: Text('${postModel.text}',
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.grey[700]),
            ),
          ),
          if(postModel.postImage != "")
            Padding(
              padding: EdgeInsets.only(
                  top: 10
              ),
              child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage('${postModel.postImage}',),
                          fit: BoxFit.cover
                      )
                  )
              ),
            ),
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        SocialCubit.get(context).likePosts(postId: SocialCubit
                            .get(context)
                            .postId[index], postModel: postModel);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: postModel.color,
                      ),
                    ),
                    Text('${postModel.likes}'),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  // if(SocialCubit.get(context).comments.isNotEmpty)
                  cubit.getComments(
                    postId: SocialCubit.get(context).postId[index],
                  );
                  navigateTo(context, commentScreen(index, postModel));
                },
                child: Row(
                  children: [
                    Icon(
                        IconlyLight.chat
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('${postModel.comments}'),
                  ],
                ),
              ),
              Spacer(),
              MaterialButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                minWidth: 1,
                child: Image(
                  image: AssetImage('assets/images/img.png'),
                  height: 45,
                  width: 37,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10
            ),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 10
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 15,
                          backgroundColor: defaultColor,
                          backgroundImage: NetworkImage('${SocialCubit
                              .get(context)
                              .userModel!
                              .profile}',
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          cursorColor: defaultColor,
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .caption,
                            border: InputBorder.none,
                            focusColor: defaultColor,
                          ),
                          textInputAction: TextInputAction.done,
                          controller: commentController,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            if (commentController.text != '') {
                              postModel.comments = postModel.comments! + 1;
                              SocialCubit.get(context).commentPosts(
                                postId: SocialCubit
                                    .get(context)
                                    .postId[index],
                                comment: commentController.text,
                                dateTime: DateFormat.Hms().format(
                                    DateTime.now()),
                              );
                              commentController.clear();
                            }
                          },
                          icon: Icon(Icons.send,
                            color: defaultColor,
                          ))
                    ],
                  ),
                ),
                // InkWell(
                //   onTap: (){
                //   },
                //   child: Row(
                //     children: [
                //       Icon(
                //         IconlyBroken.heart,
                //         color: postModel.color,
                //       ),
                //       SizedBox(
                //         width: 5,
                //       ),
                //       Text('Like'),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildUsers(SocialUserModel user,context) {
    return Row(
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
    );
  }
}
