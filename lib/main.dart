import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/social_app/cubit.dart';
import 'package:myapp/layout/social_app/social_layout.dart';
import 'package:myapp/layout/social_app/states.dart';
import 'package:myapp/modules/social_app/login/login_screen.dart';
import 'package:myapp/modules/social_app/social_regiser/cubit.dart';
import 'package:myapp/shared/network/local/cache_helper.dart';
import 'package:myapp/shared/network/remote/dio_helper.dart';
import 'package:myapp/shared/styles/themes.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/constants.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  DioHelper.init();

  Widget? widget;

  uId = CacheHelper.getData(key: 'uId');
  if(uId != null )
    {
      widget = SocialLayout();
    }
  else
    {
     widget = SocialLoginScreen();
    }
  BlocOverrides.runZoned(
        () {
          runApp(MyApp(
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
      BlocProvider(
          create: (context) => SocialCubit()..getUser(),
      ),
      BlocProvider(
          create: (context) => SocialCubitRegister(),
      ),
    ],
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {
        },
        builder:(context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
           // themeMode: CubitShop.get(context).isDark ? ThemeMode.light : ThemeMode.dark ,
            home: startWidget,
          );
        }
      ),
    );
  }
}

