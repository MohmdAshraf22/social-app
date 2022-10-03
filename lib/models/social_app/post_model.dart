import 'package:flutter/material.dart';
class PostModel
{
  String? name;
  String? uId;
  String? text;
  String? profile;
  String? postImage;
  String? postVideo;
  String? dateTime;
  bool? like;
  int? likes =0;
  int? comments=0;
  String? comment;
  Color? color;

  PostModel({
    this.name,
    this.uId,
    this.text,
    this.profile,
    this.postImage,
    this.postVideo,
    this.dateTime,
    this.like,
    this.likes,
    this.color,
    this.comment,
    this.comments
  });

  PostModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    text = json['text'];
    profile = json['profile'];
    postImage = json['postImage'];
    postVideo = json['postVideo'];
    dateTime = json['dateTime'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'uId' : uId,
      'text' : text,
      'postImage' : postImage,
      'postVideo' : postVideo,
      'dateTime' : dateTime,
      'profile' : profile,
    };
  }
}