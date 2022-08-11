class AddFavourites
{
  late bool status;
  late String message;
  AddFavourites.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}//