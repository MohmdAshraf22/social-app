import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myapp/layout/newsApp/cubit/cubit.dart';
import 'package:myapp/layout/newsApp/cubit/states.dart';
import 'package:myapp/modules/news_app/search/search_screen.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<news,NewsStates>(
      listener: (context, state) {} ,
      builder: (context, state) {
        var cubit = news.get(context);
        return Scaffold(
          body: cubit.Screen[cubit.current],
          appBar: AppBar(
            titleSpacing: 20,
            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },
                  icon: Icon(
                      Icons.search,
                    size: 30,
                  ),
              ),
              IconButton(
                onPressed: (){
                  news.get(context).ChangeMode();
                },
                  icon: Icon(
                      Icons.brightness_4_outlined,
                    size:25,
                  ),
              ),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
              onTap: (index) {
                cubit.ChangeBottom(index);
              },
            color: news.get(context).isDark? Colors.white : HexColor('333739'),
            backgroundColor: Colors.orange,
            items: [
              Icon(
                Icons.business_center_outlined,
                color: news.get(context).isDark? Colors.black : Colors.white,
              ),
              Icon(
                Icons.monitor_heart_rounded,
                color: news.get(context).isDark? Colors.black : Colors.white,
              ),
              Icon(
                Icons.sports_baseball_sharp,
                color: news.get(context).isDark? Colors.black : Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
