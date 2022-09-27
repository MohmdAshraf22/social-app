import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myapp/layout/social_app/social_layout.dart';
import 'package:myapp/layout/social_app/states.dart';
import 'package:myapp/models/social_app/chats_model.dart';
import 'package:myapp/models/social_app/comment_model.dart';
import 'package:myapp/models/social_app/post_model.dart';
import 'package:myapp/models/social_app/user_model.dart';
import 'package:myapp/modules/social_app/chats/chats_screen.dart';
import 'package:myapp/modules/social_app/create_post/create_post_screen.dart';
import 'package:myapp/modules/social_app/login/login_screen.dart';
import 'package:myapp/modules/social_app/news_feed/comments.dart';
import 'package:myapp/modules/social_app/news_feed/feed_screen.dart';
import 'package:myapp/modules/social_app/seeting/seeting_screen.dart';
import 'package:myapp/modules/social_app/user/user_Screen.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:myapp/shared/styles/colors.dart';
import 'package:video_player/video_player.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  int current = 0;
  int c = 0;
  List<String> titles =[
    'News Feed',
    'Chats',
    'Create Post',
    'People Maybe you know',
    'My profile',
  ];
  List<Widget> screens =[
    FeedScreen(),
    Chats(),
    CreatePost(),
    UserScreen(),
    SettingScreen()
  ];
  Future<void> ChangeBottom(int index) async
  {

     if(index == 1 || index == 3 || index == 4)
      {
        getFollowing();
        getFollowers();
        getUsers();
      }
    if (index == 2 )
    {
      emit(SocialPostState());
    }
    else
    {
      current = index;
      emit(SocialChangeBottomState());
    }
  }

   ChangeTap(int index)  {
      c = index;
      emit(SocialChangeTapState());
    }

  void getUser()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .get()
        .then((value) {
          userModel = SocialUserModel.fromJson(value.data()!);
          emit(SocialGetUserSuccessState());
    }).catchError((error){
      emit(SocialGetUserErrorState());
    });
  }

   File? profileImage;
   final picker = ImagePicker();
   Future<void> getImage() async
   {
     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
     if (pickedFile != null)
       {
         profileImage = File(pickedFile.path);
         emit(SocialProfilePickedSuccessState());
       }
     else
       {
         print('No image selected !!');
         emit(SocialProfilePickedErrorState());
       }
   }

  Future uploadProfile() async
  {
     Reference ref = firebase_storage.FirebaseStorage.instance.ref()
         .child('users/${Uri.file(profileImage!.path).pathSegments.last}');

          await ref.putFile(profileImage!);
          await ref.getDownloadURL().then((value) {
            userModel!.profile = value ;

            emit(SocialUploadProfileSuccessState());
          }).catchError((error){
            emit(SocialUploadProfileErrorState());
          });
   }

  Future updateUser({
  required String name,
  required String phone,
  required String bio,
    context,
})async
   {
     emit(SocialUpdateUserLoadingState());
     if(profileImage != null) {
       await uploadProfile();
     }
         SocialUserModel? model = SocialUserModel(
             uId: userModel!.uId,
             phone: phone,
             name: name,
             bio: bio,
             isEmailVerified: false,
             profile: userModel!.profile,
         );
         print( userModel!.profile);
         FirebaseFirestore.instance.collection('users')
             .doc(userModel!.uId)
             .update(model.toMap())
             .then((value) {
            getUser();
            Navigator.pop(context);
           emit(SocialUpdateUserSuccessState());
         })
             .catchError((error) {
           emit(SocialUpdateUserErrorState());
         });
       }

  File? postImage;
  Future<void> getPostImage(source,context)async
  {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null)
    {
      postImage = File(pickedFile.path);
      Navigator.pop(context);
      emit(SocialProfilePickedSuccessState());
    }
    else
    {
      print('No image selected !!');
      emit(SocialProfilePickedErrorState());
    }
  }

  String uploadPostImage = '';
  Future<void> uploadPostImages() async
  {
    Reference ref = firebase_storage.FirebaseStorage.instance.ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}');

    await ref.putFile(postImage!);
    await ref.getDownloadURL().then((value) {
     // postModel!.postImage = value ;
      uploadPostImage = value ;

      emit(SocialUploadPostImageSuccessState());
    }).catchError((error){
      emit(SocialUploadPostImageErrorState());
    });
  }


  File? postVideo;
  VideoPlayerController? videoPlayerController;
  Future<void> getPostVideo(source,context)async
  {
    final pickedFile = await picker.pickVideo(source: source );
    if (pickedFile != null)
    {
      postVideo = File(pickedFile.path);

      videoPlayerController = VideoPlayerController.file(postVideo!)..addListener(() {
        emit(SocialVideoPlayerSuccessState());
      })..setLooping(true)..initialize().then((_) {
        videoPlayerController!.play();
        emit(SocialVideoPlayerSuccessState());
      });
    //   final chewieController = ChewieController(
    //  videoPlayerController: videoPlayerController! ,
    //  autoPlay: true,
    //  looping: true,
    //     aspectRatio: 15/9,
    // );
    //   final playerWidget = Chewie(
    //     controller: chewieController,
    //   );

      Navigator.pop(context);
      emit(SocialProfilePickedSuccessState());
    }
    else
    {
      print('No video selected !!');
      emit(SocialProfilePickedErrorState());
    }
  }

  IconData? icon;
  bool? isPlay;
 void playVideo(){
   if(isPlay == false) {
     isPlay = true;
     icon = Icons.play_arrow;
     videoPlayerController!.play();
   }
   else {
     isPlay = false;
     icon = Icons.pause;
     videoPlayerController!.pause();
   }
   emit(SocialVideoIsPauseState());
 }

  bool? play = true;
  void playShow()
 {
   play = !play!;
   emit(SocialVideoIsPlayState());

 }

  String? uploadVideo = '';
  Future<void> uploadPostVideo() async
  {
    Reference ref = firebase_storage.FirebaseStorage.instance.ref()
        .child('posts/${Uri.file(postVideo!.path).pathSegments.last}');

    await ref.putFile(postVideo!);
    await ref.getDownloadURL().then((value) {
      uploadVideo = value ;

      emit(SocialUploadPostImageSuccessState());
    }).catchError((error){
      emit(SocialUploadPostImageErrorState());
    });
  }

  Future<void> createPost({
  required String text,
  required String dateTime,
    context,
})async
    {
    emit(SocialCreatePostLoadingState());
    if (postImage != null)
      await uploadPostImages();
    if(postVideo != null)
      await uploadPostVideo();
    PostModel? model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      profile: userModel!.profile,
      text: text,
      dateTime: dateTime,
      postImage: uploadPostImage,
      postVideo: uploadVideo,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
          navigateTo(context, SocialLayout());
          emit(SocialCreatePostSuccessState());
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage()
  {
    postImage = null;
   emit(SocialRemovePostImageState());
  }
  void removePostVideo()
  {
    postVideo = null;
    videoPlayerController!.pause();
    emit(SocialRemovePostImageState());

  }

  void showSimpleDialogPhoto(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          elevation: 7,
          title: Text('Choose from options ',
          style: TextStyle(color: defaultColor),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                minLeadingWidth: 0,
                leading: Icon(IconlyBroken.image,
                    color: Colors.black),
                title: Text('Gallery',
                  style: TextStyle(
                fontWeight: FontWeight.w600
                ),),
                onTap: (){
                  getPostImage(ImageSource.gallery,context);
                },
              ),
              ListTile(
                minLeadingWidth: 0,
                leading: Icon(IconlyBroken.camera,
                color: Colors.black,),
                title: Text('Camera',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600
                ),),
                onTap: (){
                  getPostImage(ImageSource.camera,context);
                },
              ),
            ],
          ),
        )
    );
  }
  void showSimpleDialogLogout(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
            elevation: 7,
          title: Text('Do you want Logout ?',
          style: TextStyle(color: defaultColor),),
          actions: [
            TextButton(
              child:  Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Text('Cancel',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: Text('Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400
                ),
                  ),
              ),
              onPressed: () {
                signOut(context);
              },
            ),
          ]
        )
    );
  }
  void showSimpleDialogVideo(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          elevation: 7,
          title: Text('Choose from options ',
          style: TextStyle(color: defaultColor),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                minLeadingWidth: 0,
                leading: Icon(IconlyBroken.image,
                    color: Colors.black),
                title: Text('Gallery',
                  style: TextStyle(
                fontWeight: FontWeight.w600
                ),),
                onTap: (){
                  getPostVideo(ImageSource.gallery,context);
                },
              ),
              ListTile(
                minLeadingWidth: 0,
                leading: Icon(IconlyBroken.camera,
                color: Colors.black,),
                title: Text('Camera',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w600
                ),),
                onTap: (){
                  getPostVideo(ImageSource.camera,context);
                },
              ),
            ],
          ),
        )
    );
  }

  List<PostModel> posts = [];
  List<PostModel> myPosts = [];
  List<String> postId = [];
  void getPosts()
  {
    FirebaseFirestore.instance.collection('posts').orderBy('dateTime')
        .get()
        .then((value) {
      posts = [];
      myPosts = [];
      value.docs.forEach((element) {
        PostModel postModel = PostModel.fromJson(element.data());
        element.reference.collection('likes').get().then((value) {
              postModel.likes = value.docs.length;

              value.docs.forEach((element) {
                 if(uId == element.id)
                  {
                    postModel.like = true;
                    postModel.color = Colors.red;
                  }
              });

            }).catchError((error){});
            postId.add(element.id);

        element.reference.collection('comments').get().then((value) {
          postModel.comments = value.docs.length;
        });
              posts.add(postModel);
              if(uId == postModel.uId) {
                myPosts.add(postModel);
              }
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error){
      emit(SocialGetPostsErrorState());
    });
  }

  void likePosts({
    String? postId,
    PostModel? postModel,
}){
    if(postModel!.like == false)
      {
        postModel.likes = postModel.likes! - 1;
        postModel.color = Colors.black;
        FirebaseFirestore.instance.collection('posts')
            .doc(postId)
            .collection('likes')
            .doc(uId)
            .delete()
            .then((value) {
          emit(SocialPostLikeSuccessState());
        }).catchError((error){
          emit(SocialPostLikeErrorState());
        });
        postModel.like = true;
      }
    else
      {
        postModel.likes = postModel.likes! + 1;
        postModel.color = Colors.red;
        FirebaseFirestore.instance.collection('posts')
            .doc(postId)
            .collection('likes')
            .doc(uId)
            .set({
          'like': true
        })
         .then((value) {
          emit(SocialPostLikeSuccessState());
        }).catchError((error){
          emit(SocialPostLikeErrorState());
        });
        postModel.like = false;
      }
  }

  void commentPosts({
    String? postId,
    String? comment,
    String? dateTime,
  })
  {
    CommentModel commentModel = CommentModel(
      name: userModel!.name,
      profile: userModel!.profile,
      text: comment,
      uId: userModel!.uId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance.collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      emit(SocialPostCommentSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialPostCommentErrorState());
    });
  }

  List<SocialUserModel> users = [];
  List<String> followingId = [];
  int? following;
  List? Followers = [];
  getUsers()
  {
    users = [];
    Followers!.clear();
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value){
      users = [];
      value.docs.forEach((element) {
        SocialUserModel user = SocialUserModel.fromJson(element.data());
            if(element.id != userModel!.uId) {
              users.add(user);
            }
            followingId.forEach((e) {
              if(e == element.id)
                {
                  user.follow = true;
                  user.colorFollowButton = Colors.grey[200];
                  user.colorFollowText = Colors.black;
                  user.textFollow = 'following';
                }
            });

      });
      emit(SocialGetUsersSuccessState());
    }).catchError((error){
          print(error.toString());
      emit(SocialGetUsersErrorState());
    });
  }

  List<CommentModel> comments = [];
   void getComments({
    String? postId,
  })
  {
      FirebaseFirestore.instance.collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
        comments = [];
          event.docs.forEach((element){
            comments.add(CommentModel.fromJson(element.data()));
          });
          emit(SocialGetCommentsSuccessState());
      });
  }

  void deleteComment({
    String? postId,
     id,
  })
  {
    FirebaseFirestore.instance.collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(id)
        .delete()
        .then((value) {
      emit(SocialDeleteCommentSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialDeleteCommentErrorState());
    });
  }
  
  void sendMessage({
  String? hisId,
  String? message,
  String? datetime,
  })
  {
    MessageModel messageModel = MessageModel(
      hisId: hisId,
      dateTime: datetime,
      myId: userModel!.uId,
      message: message
    );
     FirebaseFirestore.instance
         .collection('users')
         .doc(uId)
         .collection('chats')
         .doc(hisId)
         .collection('messages')
         .add(messageModel.toMap())
         .then((value) {
           emit(SocialSendMessageSuccessState());
     })
         .catchError((error){
           emit(SocialSendMessageErrorState());
     });

    FirebaseFirestore.instance
        .collection('users')
        .doc(hisId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages =[];
  void getMessage({
    String? hisId,
  })
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(hisId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
           messages = [];
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(SocialGetMessageSuccessState());
    });
  }


  void changePassword(context,String currentPassword, String newPassword)
  async {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: currentPassword);

     user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        //Success, do something
        if (currentPassword != newPassword) {
          showToast(text: 'The password has been changed ..Please login again',  state: ToastColor.SUCCESS);
          current = 0;
          signOut(context);
        }
        if(currentPassword == newPassword) {
          showToast(text: 'The password has not changed', state: ToastColor.ERROR);
        }
      }).catchError((error) {
        //Error, show something
        showToast(text: 'The new password is emtpy', state: ToastColor.ERROR);

      });
    }).catchError((error) {
      showToast(text: 'Current pass is wrong', state: ToastColor.ERROR);
    });
  }



  void followers({
  String? uId,
  SocialUserModel? user,
})
  {
    //print(user!.follow);
    user!.follow = !user.follow!;
    if(user.follow == false)
    {
      user.colorFollowButton = defaultColor;
      user.colorFollowText = Colors.white;
      user.textFollow = 'follow';

      FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('following')
        .doc(uId)
        .delete()
        .then((value) {
          emit(SocialFollowState());
    })
        .catchError((error){});
      ///////////////////////
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('followers')
          .doc(userModel!.uId)
          .delete()
          .then((value) {
        emit(SocialFollowState());
      })
          .catchError((error){});
    }
    else
      {
        user.colorFollowButton = Colors.grey[200];
        user.colorFollowText = Colors.black;
        user.textFollow = 'following';
          FirebaseFirestore.instance
              .collection('users')
              .doc(userModel!.uId)
              .collection('following')
              .doc(uId)
              .set({
            'follow': true
              })
              .then((value) {
            emit(SocialFollowState());
          })
              .catchError((error){});
//////////////////////////////////////////////////
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .collection('followers')
            .doc(userModel!.uId)
            .set({
          'follow': true
        })
            .then((value) {
          emit(SocialFollowState());
        }).catchError((error){});

      }
  }


   void getFollowing(){
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('following')
        .snapshots()
    .listen((event) {
      followingId = [];
      following = event.docs.length;
      event.docs.forEach((element) {
      followingId.add(element.id);
      });
      emit(SocialGetFollowState());
    });
  }

  List<String> followersId = [];
  int? follower;

  // void getFollowers() {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uId)
  //       .collection('followers')
  //       .snapshots()
  //       .listen((event) {
  //     followersId = [];
  //     follower = event.docs.length;
  //     event.docs.forEach((element) {
  //       followersId.add(element.id);
  //     });
  //     emit(SocialGetFollowersState());
  //   });
  // }
  void getFollowers() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('followers')
        .get()
        .then((value) {
      Followers!.clear();
      follower = value.docs.length;
      value.docs.forEach((element) {
        followersId.add(element.id);
        FirebaseFirestore.instance.collection('users').doc(element.id).get().then((value) {
          Followers!.add(SocialUserModel.fromJson(value.data()!));
        });
      });
      emit(SocialGetFollowersState());
    });
  }
}

