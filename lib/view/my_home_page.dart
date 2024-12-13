import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/viewmodel/app_data_state.dart';
import 'package:flutter_architectural_flow/viewmodel/app_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final AppViewModel _appViewModel;

  @override
  void initState() {
    _appViewModel = context.read<AppViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocConsumer<AppViewModel, AppDataState>(
        listener: (context, state){
          log("$state");
          if(state.apiResponseState == ApiState.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to perform this action'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              if(state.apiResponseState == ApiState.loading) const Center(
                child: CircularProgressIndicator(),
              ),
              if(state.apiResponseState == ApiState.success) ListView.builder(
                  key: const Key("listView"),
                  itemCount: state.appData?.dogBreedList?.length,
                  itemBuilder: (context, pos) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ListTile(
                          key: Key("listItem${pos+1}"),
                          tileColor: Colors.blueGrey,
                          title: Text(state.appData?.dogBreedList?[pos].dogBreedAttrs?.name ?? "No Name",
                            style: const TextStyle(fontSize: 24),
                          ),
                        ));
                  }),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _appViewModel.getDogListData();
        },
        tooltip: 'Dog List Generate',
        child: const Icon(Icons.generating_tokens_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}