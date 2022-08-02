import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/shared/bloc/cubit.dart';
import 'package:myapp/shared/bloc/states.dart';
import 'package:myapp/shared/components/components.dart';


class ArchivedTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDo,TodoState>(
      listener: (context, state) => {},
      builder: (context, state) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(ToDo.get(context).archiveTasks[index],context),
        separatorBuilder: (context, index) => Padding(
          padding:  EdgeInsetsDirectional.only(
            start: 20,
          ),
          child: Container(
            height: 2,
            width: double.infinity,
            color: Colors.grey[400],
          ),
        ) ,
        itemCount: ToDo.get(context).archiveTasks.length,
      ),
    );
  }
}
