import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/newsApp/cubit/cubit.dart';
import 'package:myapp/layout/newsApp/cubit/states.dart';
import 'package:myapp/shared/components/components.dart';
class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<news,NewsStates>(
        listener: (context, state) {} ,
        builder: (context, state) {
          if (news.get(context).sports.length > 2) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => BuildArticleItem(news.get(context).sports[index],context),
              separatorBuilder: (context, index) => myDivider() ,
              itemCount: news.get(context).sports.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );

  }
}
