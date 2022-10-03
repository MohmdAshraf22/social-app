import 'package:myapp/modules/social_app/login/login_screen.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/network/local/cache_helper.dart';

String? token ='';
String? uId ='';
void signOut(context)
{
  CacheHelper.removeData(
      key: 'uId',
  ).then((value) {
    if(value) {
      navigateAndFinish(context, SocialLoginScreen());
    }
  });
}