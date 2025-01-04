import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/core/constants.dart';
import 'package:flutter_architectural_flow/data_classes/blog_data.dart';
import 'package:flutter_architectural_flow/view/edit_dialog.dart';
import 'package:flutter_architectural_flow/viewmodel/app_data_state.dart';
import 'package:flutter_architectural_flow/viewmodel/app_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AdminListShowcaseScreen extends StatefulWidget {
  const AdminListShowcaseScreen({super.key});

  @override
  State<AdminListShowcaseScreen> createState() =>
      _AdminListShowcaseScreenState();
}

class _AdminListShowcaseScreenState extends State<AdminListShowcaseScreen> {
  int _toggleIndex = 0;
  late final AppViewModel _appViewModel;
  List<Blog> _blogList = [];

  @override
  void initState() {
    _appViewModel = context.read<AppViewModel>();
    _appViewModel.getBlogData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blogs to Showcase!"),
        actions: [
          ToggleSwitch(
            initialLabelIndex: _toggleIndex,
            totalSwitches: 2,
            labels: const ['India', 'UK'],
            onToggle: (index) {
              setState(() {
                _toggleIndex = index ?? 0;
                switch(_toggleIndex){
                  case 0:
                    _blogList = _appViewModel.state.appData?.indiaBlogs ?? [];
                    break;
                  case 1:
                    _blogList = _appViewModel.state.appData?.ukBlogs ?? [];
                }
              });
            },
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: BlocConsumer<AppViewModel, AppDataState>(
          listener: (context, state){
            switch(_toggleIndex){
              case 0:
                _blogList = _appViewModel.state.appData?.indiaBlogs ?? [];
                break;
              case 1:
                _blogList = _appViewModel.state.appData?.ukBlogs ?? [];
            }
            if(state.apiResponseState == ApiState.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to perform this action'),
                ),
              );
            }
          },
        builder: (context, state) {
          return ListView.builder(
              itemCount: _blogList.length,
              itemBuilder: (context, pos) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: ListTile(
                    tileColor: Colors.black12,
                    leading: Image.network(
                        _blogList[pos].bannerUrl ?? strConstant),
                    title: Text(
                      _blogList[pos].title ?? strConstant,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      _blogList[pos].shortDesc ?? strConstant,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(_blogList[pos].pubclicationDate ?? strConstant), Text(_blogList[pos].topic ?? strConstant)],
                        ),
                        IconButton(
                            onPressed: () {
                              showEditDialog(context, "Edit Blog Details!");
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            )),
                      ],
                    ),
                  ),
                );
              });
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditDialog(context, "Add New Blog!");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
