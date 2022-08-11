
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myapp/layout/newsApp/cubit/cubit.dart';
import 'package:myapp/layout/newsApp/cubit/states.dart';
import 'package:myapp/layout/newsApp/news_layout.dart';
import 'package:myapp/layout/shop_app/cubit_shop.dart';
import 'package:myapp/layout/shop_app/shop_layout.dart';
import 'package:myapp/layout/shop_app/states_shop.dart';
import 'package:myapp/layout/todoApp/todo_layout.dart';
import 'package:myapp/modules/basics_app/login/login.dart';
import 'package:myapp/modules/shop_app/login/shop_login.dart';
import 'package:myapp/modules/shop_app/on_boarding/on_boardin_screen.dart';
import 'package:myapp/shared/bloc/cubit.dart';
import 'package:myapp/shared/bloc/states.dart';
import 'package:myapp/shared/network/local/cache_helper.dart';
import 'package:myapp/shared/network/remote/dio_helper.dart';
import 'package:myapp/shared/styles/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();

  Widget widget;
  bool? isDark = CacheHelper.getData(key: 'isDark')??true;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  print(token.toString());

  if(onBoarding != null)
    {
      if(token != null)
        {
          widget = ShopLayout();
        }
      else
        {
          widget = ShopLogin();
        }
    }
  else
    {
      widget = onBoardingScreen();
    }
  BlocOverrides.runZoned(
        () {
          runApp(MyApp(
            isDark: isDark,
            startWidget: widget,
          ));
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget
{
//// c r u d
  final bool? isDark;
  final Widget? startWidget ;
  MyApp({
    this.isDark,
    this.startWidget
});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
    //     BlocProvider(
    //       create: (context) => news()..getBusiness()..ChangeMode(
    //     fromShared: isDark,
    // ),),
    //     BlocProvider(
    //       create: (context) => ToDo()..createDatabase(),
    //     ),
        BlocProvider(
          create: (context) => CubitShop()..ChangeMode(
        fromShared: isDark,
       )..getHomeData()..getCategoriesModel()..getFavourite()..getProfile(),
        ),
      ],
      child: BlocConsumer<CubitShop,ShopStates>(
        listener: (context, state) {
        },
        builder:(context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: CubitShop.get(context).isDark ? ThemeMode.light : ThemeMode.dark ,
            home: startWidget,
          );
        }
      ),
    );
  }
}

