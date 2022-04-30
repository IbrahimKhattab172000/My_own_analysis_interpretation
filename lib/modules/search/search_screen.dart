// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:abdullah_mansour/layout/news_app/cubit/cubit.dart';
import 'package:abdullah_mansour/layout/news_app/cubit/states.dart';
import 'package:abdullah_mansour/shared/components/components.dart';
import 'package:abdullah_mansour/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Search"),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: defaultTextFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value) {
                    //*Recalling getsearch method in which it's filling up the [search list]...
                    //*... every time the user enters a value..
                    NewsCubit.get(context).getSearch(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Search must not be empty";
                    }
                    return null;
                  },
                  lable: "Search",
                  border: OutlineInputBorder(),
                  prefix: Icons.search,
                ),
              ),
              list.isNotEmpty
                  ? Expanded(
                      child: articleBuilder(
                        //*Showing our list here in that articleBuilder
                        list: list,
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LinearProgressIndicator(),
                          ),
                          Text("Waiting ..."),
                        ],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
