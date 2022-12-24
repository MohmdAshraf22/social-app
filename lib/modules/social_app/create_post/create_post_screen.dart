import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:myapp/layout/social_app/cubit.dart';
import 'package:myapp/layout/social_app/states.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/styles/colors.dart';
import 'package:video_player/video_player.dart';

class CreatePost extends StatelessWidget {
  var textController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {
        },
      builder: (context, state) {
          var cubit = SocialCubit.get(context);
          var postImage = SocialCubit.get(context).postImage;
          // var videoPlayerController = SocialCubit.get(context).videoPlayerController;
        return Scaffold(
          appBar: AppBar(
            title: Text('Create Post'),
            titleSpacing: 0,
            actions: [
              ConditionalBuilder(
                  condition: state is! SocialCreatePostLoadingState,
                  builder: (context) =>
                      defaultTextButton(
                    onPress: (){
                      cubit.createPost(
                        context: context,
                        dateTime: DateFormat.Hms().format(DateTime.now()),
                        text: textController.text,
                      );

                      cubit.removePostImage();
                    }, text: 'POST',
                    textColor: defaultColor,
                    pressColor: Colors.grey[300],
                  ),
                  fallback: (context) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: defaultColor,
                      ),
                    ),
                  ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: defaultColor,
                        backgroundImage: NetworkImage('${cubit.userModel!.profile}',),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text('${cubit.userModel!.name}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w700
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  TextFormField(
                    cursorColor: defaultColor,
                    scrollPhysics: BouncingScrollPhysics(),
                    controller: textController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      border: InputBorder.none,
                      hintText: 'What\'s on your mind ?',
                    ),
                  ),
                  if(postImage != null )
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image: FileImage(postImage),
                        fit: BoxFit.cover,),
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: defaultColor,
                        child: IconButton(
                          onPressed: (){
                            cubit.removePostImage();
                          },
                          icon: Icon(Icons.close,
                          size: 17,),)
                      )
                    ],
                  ),
                  // if(postVideo != null && videoPlayerController!.value.isInitialized)
                  // GestureDetector(
                  //   behavior: HitTestBehavior.opaque,
                  //   onTap: (){
                  //     cubit.playShow();
                  //   },
                  //   child: Stack(
                  //     alignment: Alignment.center,
                  //     children: [
                  //       Stack(
                  //           alignment: Alignment.topRight,
                  //           children: [
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(15),
                  //               child: Container(
                  //                 height: 250,
                  //                 width: double.infinity,
                  //                 child: AspectRatio(
                  //                    aspectRatio: videoPlayerController.value.aspectRatio,
                  //                    child: VideoPlayer(videoPlayerController),
                  //                  ),
                  //               ),
                  //             ),
                  //             CircleAvatar(
                  //                 radius: 15,
                  //                 backgroundColor: defaultColor,
                  //                 child: IconButton(
                  //                   onPressed: (){
                  //                     cubit.removePostVideo();
                  //                   },
                  //                   icon: Icon(Icons.close,
                  //                     size: 17,),)
                  //             )
                  //           ],
                  //         ),
                  //       if(cubit.play == true)
                  //         IconButton(
                  //           onPressed: (){
                  //             cubit.playVideo();
                  //           },
                  //           icon: Icon(
                  //           cubit.icon,
                  //           color: Colors.white,
                  //           size: 50,
                  //           ),
                  //       ),
                  //
                  //     ],
                  //   ),
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
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
                              cubit.showSimpleDialogPhoto(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconlyBroken.image_2,
                                  color: defaultColor,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Add Photo',
                                  style: TextStyle(
                                      color: defaultColor
                                  ),),
                              ],
                            )),
                      ),
                      Expanded(
                        child: TextButton(
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
                              cubit.showSimpleDialogVideo(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(IconlyBroken.video,
                                  color: defaultColor,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Add Video',
                                  style: TextStyle(
                                      color: defaultColor
                                  ),),
                              ],
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
