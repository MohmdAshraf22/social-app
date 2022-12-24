import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/shared/styles/colors.dart';

Widget defaultformfield({
  required TextEditingController controle ,
  TextInputType? type,
  bool obscure = false,
  String? label,
  String? hint,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? onpress,
  FormFieldValidator? validate,
  GestureTapCallback? ontap,
  bool isClickable = true,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  Color? iconColor,
  Color? textColor,

}) => TextFormField(
  onFieldSubmitted: onSubmit,
  cursorColor: defaultColor,
  enabled: isClickable,
  onTap: ontap,
validator: validate,
controller: controle,
keyboardType: type,
obscureText: obscure ,
decoration: InputDecoration(
  hintStyle: TextStyle(
    color: textColor
  ),
 labelStyle: TextStyle(
    color: textColor,
  ),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular (30),
  borderSide: BorderSide(
      width: 3,
      color: defaultColor
  ),

),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
        width: 3,
        color: defaultColor
    ),
  ),
labelText: label,
hintText: hint,
prefixIcon: Icon(
prefix,
  color: iconColor ,
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

Widget defaultTextButton({
  required VoidCallback onPress,
  required String text,
  Color? textColor,
  Color? pressColor,
  double? fontSize,
}) => TextButton(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return pressColor; //<-- SEE HERE
          return null; // Defer to the widget's default.
        },
      ),
    ),
    onPressed: onPress,
    child: Text(text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize
      ),));

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






