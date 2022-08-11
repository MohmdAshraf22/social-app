import 'package:myapp/modules/shop_app/login/shop_login.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/network/local/cache_helper.dart';

String token ='';
void signOut(context)
{
  CacheHelper.removeData(
      key: 'token',
  ).then((value) {
    if(value) {
      navigateAndFinish(context, ShopLogin());
    }
  });
}//