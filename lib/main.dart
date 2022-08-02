
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myapp/layout/newsApp/cubit/cubit.dart';
import 'package:myapp/layout/newsApp/cubit/states.dart';
import 'package:myapp/layout/newsApp/news_layout.dart';
import 'package:myapp/layout/todoApp/todo_layout.dart';
import 'package:myapp/shared/bloc/cubit.dart';
import 'package:myapp/shared/bloc/states.dart';
import 'package:myapp/shared/network/local/cache_helper.dart';
import 'package:myapp/shared/network/remote/dio_helper.dart';
import 'shared/bloc_observer.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');
  BlocOverrides.runZoned(
        () {
          runApp(MyApp(isDark!));
    },
    blocObserver: MyBlocObserver(),
  );
}
class MyApp extends StatelessWidget
{
//// c r u d
  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => news()..getBusiness()..ChangeMode(
      fromShared: isDark,
    ),)
      ],
      child: BlocConsumer<news,NewsStates>(
        listener: (context, state) {
        },
        builder:(context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.orange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              // floatingActionButtonTheme: FloatingActionButtonThemeData(
              //   backgroundColor: Colors.orange,
              // ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light
                ),
                elevation: 0,
                backgroundColor: HexColor('333739'),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              primarySwatch: Colors.orange,
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: news.get(context).isDark ? ThemeMode.light : ThemeMode.dark ,
            home: NewsLayout(),
          );
        }
      ),
    );
  }
}

