import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:myapp/layout/social_app/cubit.dart';
import 'package:myapp/layout/social_app/states.dart';
import 'package:myapp/models/social_app/comment_model.dart';
import 'package:myapp/models/social_app/post_model.dart';
import 'package:myapp/models/social_app/user_model.dart';
import 'package:myapp/modules/social_app/news_feed/comments.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/styles/colors.dart';

class FeedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
              condition: cubit.posts.isNotEmpty ,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Card(
                    //   elevation: 7,
                    //   child: SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     physics: BouncingScrollPhysics(),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //         horizontal: 10,
                    //       ),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.symmetric(
                    //                 vertical: 10
                    //             ),
                    //             child: Column(
                    //               children: [
                    //                 Stack(
                    //                   alignment: AlignmentDirectional.bottomEnd,
                    //                   children: [
                    //                     CircleAvatar(
                    //                       radius: 33,
                    //                       backgroundColor: defaultColor,
                    //                       child: CircleAvatar(
                    //                         radius: 30,
                    //                         backgroundColor: defaultColor,
                    //                         backgroundImage: NetworkImage('https://sm.ign.com/ign_pl/screenshot/default/hunter-x-hunter-01_nnbd.jpg',),
                    //                       ),
                    //                     ),
                    //                     CircleAvatar(
                    //                       radius: 11,
                    //                       child: Icon(
                    //                           Icons.add
                    //                       ),
                    //                       backgroundColor: defaultColor,
                    //                     ),
                    //
                    //                   ],
                    //                 ),
                    //                 SizedBox(
                    //                   height: 7,
                    //                 ),
                    //                 Text('Add Story',
                    //                     maxLines: 1,
                    //                     overflow: TextOverflow.ellipsis,
                    //                     style: TextStyle(
                    //                         fontWeight: FontWeight.w400
                    //                     )),
                    //               ],
                    //             ),
                    //           ),
                    //           SizedBox(
                    //             width: 15,),
                    //           Container(
                    //             height: 100,
                    //             child: ListView.separated(
                    //               shrinkWrap: true,
                    //               physics: NeverScrollableScrollPhysics(),
                    //               scrollDirection: Axis.horizontal,
                    //               itemBuilder: (context, index) => StoryBuild(),
                    //               separatorBuilder: (context, index) =>  SizedBox(width: 15,),
                    //               itemCount: 10,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPost(cubit.posts[index],context,index,),
                      separatorBuilder: (context, index) => SizedBox(height: 10,),
                      itemCount: cubit.posts.length,
                    ),
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator( color: defaultColor,)),
            ),
          );
        },
    );
  }
  Widget buildPost(PostModel postModel , context, index) {
    late TextEditingController commentController = TextEditingController();
    var cubit = SocialCubit.get(context);
    return Card(
      elevation: 7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
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
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text('${postModel.dateTime}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.more_vert)
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10
            ),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10
            ),
            child: Text('${postModel.text}',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.grey[700]),
            ),
          ),
          if(postModel.postImage != "")
            Padding(
              padding: const EdgeInsets.only(
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
          // if(model.postVideo != "" && SocialCubit.get(context).videoPlayerController!.value.isInitialized)
          //   ClipRRect(
          //     borderRadius: BorderRadius.circular(15),
          //     child: Container(
          //       height: 250,
          //       width: double.infinity,
          //       child: AspectRatio(
          //         aspectRatio: SocialCubit.get(context).videoPlayerController!.value.aspectRatio,
          //         child: VideoPlayer(SocialCubit.get(context).videoPlayerController!),
          //       ),
          //     ),
          //   ),
          Row(
            children: [
              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    IconButton(
                      onPressed: (){
                        SocialCubit.get(context).likePosts(postId: SocialCubit.get(context).postId[index],postModel: postModel);
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
                onTap: (){
                 // if(SocialCubit.get(context).comments.isNotEmpty)
                    cubit.getComments(postId: SocialCubit.get(context).postId[index]);
                  navigateTo(context,commentScreen(index,postModel));
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
                onPressed: (){},
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
            padding: const EdgeInsets.symmetric(
                horizontal: 10
            ),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
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
                              postModel.comments = postModel.comments!+1;
                              SocialCubit.get(context).commentPosts(
                                postId: SocialCubit.get(context).postId[index],
                                comment: commentController.text,
                                dateTime: DateFormat.Hms().format(DateTime.now()),
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
}
