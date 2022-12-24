class MessageModel
{
  String? hisId;
  String? message;

  String? myId;
  String? dateTime;

  MessageModel({
    this.hisId,
    this.myId,
    this.message,
    this.dateTime
  });


  MessageModel.fromJson(Map<String, dynamic> json)
  {
    hisId = json['hisId'];
    message = json['message'];
    myId = json['myId'];
    dateTime = json['dateTime'];
  }

  Map<String,dynamic> toMap(){
    return {
      'hisId' : hisId,
      'message' : message,
      'dateTime' : dateTime,
      'myId' : myId,
    };
  }
}