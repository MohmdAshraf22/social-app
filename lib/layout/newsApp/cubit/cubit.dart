
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/newsApp/cubit/states.dart';
import 'package:myapp/modules/newsTasks/business/business_screen.dart';
import 'package:myapp/modules/newsTasks/science/science_screen.dart';
import 'package:myapp/modules/newsTasks/sports/sports_screen.dart';
import 'package:myapp/modules/setting/settings.dart';
import 'package:myapp/shared/network/local/cache_helper.dart';
import 'package:myapp/shared/network/remote/dio_helper.dart';

class news extends Cubit<NewsStates>
{
  news() : super(InitialState());
  static news get(context) => BlocProvider.of(context);

  int current = 0 ;
//   List<String> title = [
//   'Business',
//   'Science',
//   'Sports',
// ];
  List<Widget> Screen = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];
   ChangeBottom(int value) {
    current = value;
    if (current == 1)
      getScience();
    if  (current == 2)
      getSports();
    emit(ChangeBottomState());
  }

  bool isDark = false ;
  ChangeMode({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(ChangeModeState());
    }
    else{
      isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(ChangeModeState());
    });
    }
  }

  List<dynamic> business = [];
   getBusiness(){
     emit(NewsGetBusinessLoadingState());
     DioHelper.getData(
       path: 'v2/top-headlines',
       query: {
         'country':'eg',
         'category':'business',
         'apiKey':'c58bf01151e1485fb9cac9c68ca13c6a',
       },

     ).then((value) {
       business = value.data['articles'];
       // print(business[0]['title']);
       emit(NewsGetBusinessSuccessState());
     }).catchError((error){
       emit(NewsGetBusinessErrorState(error.toString()));
       print(error.toString());
     });
   }

  List<dynamic> health = [];
  getScience(){
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'health',
        'apiKey':'c58bf01151e1485fb9cac9c68ca13c6a',
      },

    ).then((value) {
      health = value.data['articles'];
      // print(science[0]['title']);
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      emit(NewsGetScienceErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> sports = [];
  getSports(){
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'sports',
        'apiKey':'c58bf01151e1485fb9cac9c68ca13c6a',
      },

    ).then((value) {
      sports = value.data['articles'];
      // print(sports[0]['title']);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      emit(NewsGetSportsErrorState(error.toString()));
      print(error.toString());
    });
  }

  List<dynamic> search = [];
  getSearch(String index){
    // search= [];
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      path: 'v2/everything',
      query: {
        'q': '$index',
        'apiKey':'c58bf01151e1485fb9cac9c68ca13c6a',
      },

    ).then((value) {
      search = value.data['articles'];
      // print(sports[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      emit(NewsGetSearchErrorState(error.toString()));
      print(error.toString());
    });
  }
}