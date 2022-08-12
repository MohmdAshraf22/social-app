import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/layout/shop_app/cubit_shop.dart';
import 'package:myapp/models/shop_app/get_fav_model.dart';
import 'package:myapp/modules/news_app/web_view/web_view.dart';
import 'package:myapp/shared/bloc/cubit.dart';
import 'package:myapp/shared/styles/colors.dart';

Widget defaultformfield({
  required TextEditingController controle ,
  TextInputType? type,
  bool obscure = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? onpress,
  FormFieldValidator? validate,
  GestureTapCallback? ontap,
  bool isClickable = true,
  ValueChanged<String>? onSubmit,
  Color? cursorcolor,
  ValueChanged<String>? onChange,
}) => TextFormField(
  onFieldSubmitted: onSubmit,
  cursorColor: cursorcolor,
  enabled: isClickable,
  onTap: ontap,
validator: validate,
controller: controle,
keyboardType: type,
obscureText: obscure ,
decoration: InputDecoration(
border: OutlineInputBorder(
borderRadius: BorderRadius.circular (30),
),
labelText: label,
prefixIcon: Icon(
prefix
),
suffixIcon:IconButton(
icon : Icon(
  suffix,
),

onPressed: onpress,
),
),
  onChanged: onChange,
);


Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['title']),
  child: Padding(
    padding: EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(

          radius: 35,

          child: Text('${model['time']}',

            ),

        ),
        SizedBox(width: 20,),
        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children: [

              Text('${model['title']}',

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                  fontSize: 20,

                ),),

              Text('${model['date']}',

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(

                    fontSize: 18,

                    color: Colors.grey

                ),),

            ],

          ),

        ),
        IconButton(

          onPressed: (){

            ToDo.get(context).UpdateData(

                status: 'done',

              id: model['id'],

            );

            },

            icon: Icon(

              Icons.check_box,

              color: Colors.greenAccent,

            ) ,

        ),
        SizedBox(width: 12,),
        IconButton(

          onPressed: (){

            ToDo.get(context).UpdateData(

                status: 'archive',

                id: model['id'],

            );

          },

          icon: Icon(

            Icons.archive,

            color: Colors.black54,

          ) ,

        ),
      ],
    ),
  ),
  onDismissed: (direction){
  ToDo.get(context).DeleteData(id: model['id']);
  },
);
Widget BuildArticleItem(list,context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(list['url']));
  },
  child:   Padding(
  
    padding: EdgeInsets.all(20),
  
    child: Row(
  
      children: [
  
        Container(
  
          height: 120,
  
          width: 120,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(12),
  
            image: DecorationImage(
  
              image: NetworkImage('${list['urlToImage']==null? 'https://image.shutterstock.com/image-vector/hacked-glitched-abstract-digital-background-260nw-1053850997.jpg' : list['urlToImage']}'),
  
              fit: BoxFit.cover,
  
            ),
  
          ),
  
        ),
  
        SizedBox(width: 15,),
  
        Expanded(
  
          child: Container(
  
            height: 130,
  
            child: Column(
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text('${list['title']}',
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                  ),
  
                ),
  
                Text('${list['publishedAt'] }',
  
                  style: TextStyle(
  
                      color: Colors.grey
  
                  ),),
  
              ],
  
            ),
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);

Widget myDivider() => Padding(
  padding:  EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey[400],
  ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) =>
      ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => BuildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,),
  fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
);

navigateTo(context , widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
navigateAndFinish(context , widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(
  builder: (context) => widget,
), (route) => false
);

void showToast({
  required String text ,
  required ToastColor state ,

}) =>  Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: ChangeToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastColor {SUCCESS,ERROR,WARNING}
Color ChangeToastColor(ToastColor state)
{
  Color color;
  switch(state){
    case ToastColor.SUCCESS:
    color = Colors.green;
    break;
    case ToastColor.ERROR:
      color = Colors.red;
      break;
    case ToastColor.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}


void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Widget buildListProduct(model,context,{bool? isOldPrice = true}) => Padding(
  padding:  EdgeInsets.all(20.0),
  child: Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Card(
            elevation: 10,
            child: Image(
              image: NetworkImage('${model!.image}'),
              height: 120,
              width: 120,
            ),
          ),
          if(model!.discount != 0 && isOldPrice! )
            Container(
              width: 60,
              color: Colors.red,
              child: Text('DISCOUNT'
                ,style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${model!.name}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Text('${model!.price}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                if(model!.discount != 0 && isOldPrice!)
                  Text('${model!.oldPrice}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Spacer(),
                IconButton(
                  onPressed: (){
                    CubitShop.get(context).postFavouriteModel(model!.id??1);
                  },
                  icon: CircleAvatar(
                    backgroundColor : CubitShop.get(context).favourite == true? Colors.grey : defaultColor ,
                    radius: 14,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
);



