import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myapp/layout/social_app/cubit.dart';
import 'package:myapp/layout/social_app/states.dart';
import 'package:myapp/models/social_app/comment_model.dart';
import 'package:myapp/models/social_app/post_model.dart';
import 'package:myapp/shared/styles/colors.dart';

class commentScreen extends StatelessWidget {

  late PostModel postModel;
  late TextEditingController commentController = TextEditingController();
  late int indexPost;
  late int indexComment;
  commentScreen(this.indexPost,this.postModel);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
      },
      builder: (context, state) {

        return Scaffold(
          appBar: AppBar(
            title: Text('Comments'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        indexComment = index;

                        return Padding(
                          padding: const EdgeInsets.all(10,),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                  radius: 24,
                                  backgroundColor: defaultColor,
                                  backgroundImage: NetworkImage('${SocialCubit.get(context).comments[index].profile}',
                                  )),
                              SizedBox(
                                width: 7,
                              ),

                              Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[300],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${SocialCubit.get(context).comments[index].name}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 14),
                                    ),
                                    SizedBox(

                                      height: 3,
                                    ),
                                    Text('${SocialCubit.get(context).comments[index].text}',
                                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  ],

                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: (){
                                    SocialCubit.get(context).deleteComment(
                                      postId: SocialCubit.get(context).postId[indexPost],
                                       id: SocialCubit.get(context).comments[index]
                                    );
                                  },
                                  icon: Icon(Icons.more_vert)
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 10,),
                      itemCount: SocialCubit.get(context).comments.length
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 15,
                                backgroundColor: defaultColor,
                                backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.profile}',
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                cursorColor: defaultColor,
                                decoration: InputDecoration(
                                  hintText: 'Write a comment...',
                                  hintStyle: Theme.of(context).textTheme.caption,
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
                                        postId: SocialCubit.get(context).postId[indexPost],
                                        comment: commentController.text,
                                        dateTime: DateTime.now().toString()
                                    );
                                    commentController.clear();

                                    SocialCubit.get(context).getComments(
                                        postId: SocialCubit.get(context).postId[indexPost],
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
          ),
        );
      },
    );
  }
}
