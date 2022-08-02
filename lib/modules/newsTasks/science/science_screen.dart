import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/newsApp/cubit/cubit.dart';
import 'package:myapp/layout/newsApp/cubit/states.dart';
import 'package:myapp/shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<news,NewsStates>(
        listener: (context, state) {} ,
        builder: (context, state) {
         var list = news.get(context).health;
          if (list.length > 0) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => BuildArticleItem(list[index],context),
              separatorBuilder: (context, index) => myDivider() ,
              itemCount: list.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}
