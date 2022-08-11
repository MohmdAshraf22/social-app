import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/shop_app/cubit_shop.dart';
import 'package:myapp/layout/shop_app/states_shop.dart';
import 'package:myapp/models/shop_app/get_fav_model.dart';
import 'package:myapp/shared/components/components.dart';
import 'package:myapp/shared/styles/colors.dart';

class FavouriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop,ShopStates>(
      listener: (context, state) {
//
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavouriteModel,
          builder: (context) =>  ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFav(CubitShop.get(context).favouriteModel!.data!.data![index],context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: CubitShop.get(context).favouriteModel!.data!.data!.length
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFav(FavData model,context) => Padding(
    padding:  EdgeInsets.all(20.0),
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Card(
              elevation: 10,
              child: Image(
                image: NetworkImage('${model.product!.image}'),
                height: 120,
                width: 120,
              ),
            ),
            if(model.product!.discount != 0)
              Container(
                width: 60,
                color: Colors.red,
                child: Text('DISCOUNT'
                  ,style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model.product!.name}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text('${model.product!.price}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if(model.product!.discount != 0)
                    Text('${model.product!.oldPrice}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                       CubitShop.get(context).postFavouriteModel(model.product!.id??1);
                    },
                    icon: CircleAvatar(
                      backgroundColor : CubitShop.get(context).favourite == true? Colors.grey : defaultColor ,
                      radius: 14,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
