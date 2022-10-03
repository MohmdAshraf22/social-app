import 'package:flutter/material.dart';
import 'package:myapp/shared/styles/colors.dart';
class SocialUserModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;
  bool? isEmailVerified;
  String? profile;
  String? bio;
  bool? follow = false;
  Color? colorFollowButton = defaultColor;
  Color? colorFollowText =Colors.white;
  String? textFollow = 'follow';

  SocialUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.isEmailVerified,
    this.profile,
    this.bio,
    this.follow,
    this.textFollow,
    this.colorFollowText,
    this.colorFollowButton,
});

  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
    profile = json['profile'];
    // colorFollowButton = json['colorFollowButton'];
    // colorFollowText = json['colorFollowText'];
    // textFollow = json['textFollow'];
  }

  Map<String,dynamic> toMap(){
  return {
   'name' : name,
   'phone' : phone,
   'email' : email,
   'uId' : uId,
   'bio' : bio,
   'isEmailVerified' : isEmailVerified,
   'profile' : profile,
   // 'colorFollowButton' : colorFollowButton,
   // 'colorFollowText' : colorFollowText,
   // 'textFollow' : textFollow,
  };
}
}