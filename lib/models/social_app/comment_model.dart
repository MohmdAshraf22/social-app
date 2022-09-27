class CommentModel
{
String? name;
String? uId;
String? profile;
String? text;
String? dateTime;
String? commentId;

CommentModel({
    this.name,
    this.uId,
    this.profile,
    this.text,
  this.dateTime,
  this.commentId,
  });

CommentModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    uId = json['uId'];
    text = json['text'];
    profile = json['profile'];
    dateTime = json['dateTime'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'uId' : uId,
      'text' : text,
      'profile' : profile,
      'dateTime' : dateTime,
    };
  }
}