
import 'package:myapp/models/shop_app/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/shop_app/states_shop.dart';
import 'package:myapp/models/shop_app/categories_model.dart';
import 'package:myapp/models/shop_app/favourite_model.dart';
import 'package:myapp/models/shop_app/get_fav_model.dart';
import 'package:myapp/models/shop_app/get_fav_model.dart';
import 'package:myapp/models/shop_app/home_model.dart';
import 'package:myapp/models/shop_app/profile_model.dart';
import 'package:myapp/modules/shop_app/categories/categories_screen.dart';
import 'package:myapp/modules/shop_app/favourits/favourite_screen.dart';
import 'package:myapp/modules/shop_app/products/product_screen.dart';
import 'package:myapp/modules/shop_app/setting/settings.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/components/constants.dart';
import 'package:myapp/shared/network/end_points.dart';
import 'package:myapp/shared/network/local/cache_helper.dart';
import 'package:myapp/shared/network/remote/dio_helper.dart';

class CubitShop extends Cubit<ShopStates> {
  CubitShop() : super(InitialState());
//
  static CubitShop get(context) => BlocProvider.of(context);

  int current = 0;
  List<Widget> BottomScreens = [
    ProductScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void ChangeCurrent(int value) {
    current = value;
    emit(ChangeCurrentState());
  }

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map<int, bool>? favourite = {};
  AddFavourites? addFavourites;
  GetFavouriteModel? favouriteModel;

  void getHomeData() {
    emit(ShopLadingHomeData());
    DioHelper.getData(
      path: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element) {
        favourite!.addAll({
          element.id: element.in_favorites,
        });
      });
      emit(ShopSuccessHomeData());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(ShopErrorHomeData());
    });
  }

  void getCategoriesModel() {
    DioHelper.getData(
      path: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data) ;
      emit(ShopSuccessCategoriesModel());
    }).catchError((error) {
      emit(ShopErrorCategoriesModel());
    });
  }

  void postFavouriteModel(int idFav) {
    if (favourite![idFav] == false) {

      favourite![idFav] = true;
      emit(ShopChangeFavouritesModel());
    }
    else {
      favourite![idFav] = false;
      emit(ShopChangeFavouritesModel());
    }

      DioHelper.postData(
        path: FAVOURITES,
        data: {
          'product_id': idFav
        },
        token: token,

      ).then((value) {
        addFavourites = AddFavourites.fromJson(value.data);
        if(!addFavourites!.status){
          if (favourite![idFav] == false) {
            favourite![idFav] = true;
          }
          else {
            favourite![idFav] = false;
          }
        }
        else getFavourite();
        emit(ShopSuccessFavouritesModel(addFavourites));
      }).catchError((error) {
        if(!addFavourites!.status ){
          if (favourite![idFav] == false) {
            favourite![idFav] = true;
          }
          else {
            favourite![idFav] = false;
          }
        }
        emit(ShopErrorFavouritesModel());
      });

  }

  void getFavourite() {
    emit(ShopLoadingGetFavouriteModel());
    DioHelper.getData(
      path: FAVOURITES,
      token: token,
    ).then((value) {
      favouriteModel = GetFavouriteModel.fromJson(value.data);
      emit(ShopSuccessGetFavouriteModel());
    }).catchError((error) {
      emit(ShopErrorGetFavouriteModel());
    });
  }

  ShopProfileModel? userProfile;

  void getProfile()
  {
    DioHelper.getData(
      path: PROFILE,
      token: token,
    ).then((value) {
      userProfile = ShopProfileModel.fromJson(value.data);

      emit(ShopSuccessGetProfile());
    }).catchError((error){
      print('error is ${error.toString()}');
      emit(ShopErrorGetProfile());
    });
  }

  void updateProfile({
    required String name,
    required String phone,
    required String email,
  })
  {
    emit(ShopLoadingUpdateProfile());
    DioHelper.putData(
      path: UPDATE,
      token: token,
      data: {
        'name':name,
        'phone':phone,
        'email':email,
      },
    ).then((value) {
      userProfile = ShopProfileModel.fromJson(value.data);

      emit(ShopSuccessUpdateProfile());
    }).catchError((error){
      print('error is ${error.toString()}');
      emit(ShopErrorUpdateProfile());
    });
  }





  bool isDark = true;
    ChangeMode({bool? fromShared}) {
      if (fromShared != null) {
        isDark = fromShared;
        emit(ChangeModeState());
      }
      else {
        isDark = !isDark;
        CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
          emit(ChangeModeState());
        });
      }
    }
  }

