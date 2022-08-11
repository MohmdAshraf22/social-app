import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/shop_app/cubit_shop.dart';
import 'package:myapp/layout/shop_app/states_shop.dart';
import 'package:myapp/models/shop_app/details_product.dart';
import 'package:myapp/models/shop_app/details_product.dart';
import 'package:myapp/models/shop_app/details_product.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop,ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
       var cubit =  CubitShop.get(context);
        return Scaffold(
          appBar: AppBar(),
          // body:
        );
      },
    );
  }
  // Widget Details() => SingleChildScrollView(
  //   child: Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: Text('${model.description}',
  //         style: TextStyle(
  //             fontSize: 16,
  //             fontWeight: FontWeight.w500
  //         )),
  //   ),
  // );
}
