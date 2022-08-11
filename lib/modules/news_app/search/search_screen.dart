
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/layout/newsApp/cubit/cubit.dart';
import 'package:myapp/layout/newsApp/cubit/states.dart';
import 'package:myapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
   var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<news,NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding:  EdgeInsets.all(20.0),
                child: Container(
                  child: defaultformfield(
                    onChange: (String value){
                      news.get(context).getSearch(value);
                    },
                    controle: search,
                    label: 'Search',
                    prefix: Icons.search,
                    validate: (value){
                      if(value.isEmpty)
                      {
                        return 'Search must not be empty';
                      }
                      return null ;
                    },
                  ),
                ),
              ),
              Expanded(child: ListView.separated(
              physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => BuildArticleItem(news.get(context).search[index],context),
        separatorBuilder: (context, index) => myDivider() ,
        itemCount: news.get(context).search.length,
        ),),
            ],
          ),
        );
      } ,
    );
  }
}
