import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/core/app_util_methods.dart';
import 'package:flutter_architectural_flow/core/constants.dart';
import 'package:flutter_architectural_flow/data_classes/blog_data.dart';
import 'package:flutter_architectural_flow/view/edit_dialog.dart';
import 'package:flutter_architectural_flow/viewmodel/blog_content_viewmodel.dart';
import 'package:flutter_architectural_flow/viewmodel/state/blog_content_update_state.dart';
import 'package:flutter_architectural_flow/viewmodel/state/blog_data_state.dart';
import 'package:flutter_architectural_flow/viewmodel/blog_data_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AdminListShowcaseScreen extends StatefulWidget {
  const AdminListShowcaseScreen({super.key, this.restorationId});
  final String? restorationId;
  @override
  State<AdminListShowcaseScreen> createState() =>
      _AdminListShowcaseScreenState();
}

class _AdminListShowcaseScreenState extends State<AdminListShowcaseScreen> with RestorationMixin {
  int _toggleIndex = 0;
  late final BlogDataViewModel _appViewModel;
  late final BlogContentViewModel _blogContentViewModel;
  List<Blog> _blogList = [];
  BlogData? _blogData;

  // Dialog Form Controllers
  late final TextEditingController _imageUrlController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _dateController;
  late final TextEditingController _topicController;
  late final TextEditingController _blogUrlController;
  late final TextEditingController _sortOrderController;

  @override
  void initState() {
    _appViewModel = context.read<BlogDataViewModel>();
    _blogContentViewModel = context.read<BlogContentViewModel>();
    _appViewModel.getBlogData();

    _imageUrlController = TextEditingController();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController();
    _topicController = TextEditingController();
    _blogUrlController = TextEditingController();
    _sortOrderController = TextEditingController();
    super.initState();
  }

  _onSubmitButtonClickForEdit(int posIndex) {
    switch(_toggleIndex){
      case 0:
        _blogData?.indiaBlogs?[posIndex].bannerUrl = _imageUrlController.text;
        _blogData?.indiaBlogs?[posIndex].title = _titleController.text;
        _blogData?.indiaBlogs?[posIndex].shortDesc = _descriptionController.text;
        _blogData?.indiaBlogs?[posIndex].pubclicationDate = _dateController.text;
        _blogData?.indiaBlogs?[posIndex].topic = _topicController.text;
        _blogData?.indiaBlogs?[posIndex].blogUrl = _blogUrlController.text;
        _blogData?.indiaBlogs?[posIndex].sortOrder = int.tryParse(_sortOrderController.text) ?? -1;
        break;
      case 1:
        _blogData?.ukBlogs?[posIndex].bannerUrl = _imageUrlController.text;
        _blogData?.ukBlogs?[posIndex].title = _titleController.text;
        _blogData?.ukBlogs?[posIndex].shortDesc = _descriptionController.text;
        _blogData?.ukBlogs?[posIndex].pubclicationDate = _dateController.text;
        _blogData?.ukBlogs?[posIndex].topic = _topicController.text;
        _blogData?.ukBlogs?[posIndex].blogUrl = _blogUrlController.text;
        _blogData?.indiaBlogs?[posIndex].sortOrder = int.tryParse(_sortOrderController.text) ?? -1;
    }
    String contentString = _blogData?.toJson().toString() ?? "";
    log("BlogData : $_blogData");
    String sanitizedContentJson = sanitizeJson(contentString);
    log("BlogData : $sanitizedContentJson");
    _blogContentViewModel.updateBlogJsonContent(sanitizedContentJson);
    Navigator.pop(context);
  }

  _onDeleteButtonClick(int posIndex){
    switch(_toggleIndex){
      case 0:
        _blogData?.indiaBlogs?.removeAt(posIndex);
        break;
      case 1:
        _blogData?.ukBlogs?.removeAt(posIndex);
    }
    String contentString = _blogData?.toJson().toString() ?? "";
    String sanitizedContentJson = sanitizeJson(contentString);
    _blogContentViewModel.updateBlogJsonContent(sanitizedContentJson);
  }

  _onSubmitButtonClickForAdd(){
    Blog newBlog = Blog();
    newBlog.bannerUrl = _imageUrlController.text;
    newBlog.title = _titleController.text;
    newBlog.shortDesc = _descriptionController.text;
    newBlog.pubclicationDate = _dateController.text;
    newBlog.topic = _topicController.text;
    newBlog.blogUrl = _blogUrlController.text;
    newBlog.sortOrder = int.tryParse(_sortOrderController.text) ?? -1;
    switch(_toggleIndex){
      case 0:
        _blogData?.indiaBlogs?.add(newBlog);
        break;
      case 1:
        _blogData?.ukBlogs?.add(newBlog);
    }
    String contentString = _blogData?.toJson().toString() ?? "";
    String sanitizedContentJson = sanitizeJson(contentString);
    _blogContentViewModel.updateBlogJsonContent(sanitizedContentJson);
    Navigator.pop(context);
  }

  _onCancelButtonClick(){
    _imageUrlController.text = "";
    _titleController.text = "";
    _descriptionController.text = "";
    _dateController.text = "";
    _topicController.text = "";
    _blogUrlController.text = "";
    _sortOrderController.text = "";
    Navigator.pop(context);
  }

  _onDateSelectionTap(){
    _restorableDatePickerRouteFuture.present();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _topicController.dispose();
    _blogUrlController.dispose();
    _sortOrderController.dispose();
    super.dispose();
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocConsumer<BlogContentViewModel, BlogContentUpdateState>(
            listener: (context, state) {
              if(state.apiResponseState == ApiState.success) {
                _appViewModel.getBlogData();
              } else if(state.apiResponseState == ApiState.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'Failed to perform this action'),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Visibility(
                  visible: state.apiResponseState == ApiState.loading,
                  child: const LinearProgressIndicator());
            }
          ),
       //   LinearProgressIndicator(),
          BlocConsumer<BlogDataViewModel, BlogDataState>(
              listener: (context, state){
                _blogData = state.appData;
                switch(_toggleIndex){
                  case 0:
                    _blogList = _appViewModel.state.appData?.indiaBlogs ?? [];
                    break;
                  case 1:
                    _blogList = _appViewModel.state.appData?.ukBlogs ?? [];
                }
                if(state.apiResponseState == ApiState.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage ?? 'Failed to perform this action'),
                    ),
                  );
                }
              },
            builder: (context, state) {
              return ListView.builder(
                  itemCount: _blogList.length,
                  shrinkWrap: true,
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
                                  _imageUrlController.text = _blogList[pos].bannerUrl ?? strConstant;
                                  _titleController.text = _blogList[pos].title ?? strConstant;
                                  _descriptionController.text = _blogList[pos].shortDesc ?? strConstant;
                                  _dateController.text = _blogList[pos].pubclicationDate ?? strConstant;
                                  _topicController.text = _blogList[pos].topic ?? strConstant;
                                  _blogUrlController.text = _blogList[pos].blogUrl ?? strConstant;
                                  _sortOrderController.text = _blogList[pos].sortOrder.toString();
                                  showEditDialog(
                                      context, "Edit Blog Details!",
                                      imageUrlController: _imageUrlController,
                                      titleController: _titleController,
                                      descriptionController: _descriptionController,
                                      dateController: _dateController,
                                      topicController: _topicController,
                                      blogUrlController: _blogUrlController,
                                      sortOrderController: _sortOrderController,
                                      onSubmitButtonClick: (){
                                        _onSubmitButtonClickForEdit(pos);
                                      },
                                    onCancelButtonClick: _onCancelButtonClick,
                                    onDateSelectionTap: _onDateSelectionTap
                                  );
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  showDialog(context: context, builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Deleting..."),
                                      content: const Text("Are you sure?"),
                                      actions: [
                                        ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel")),
                                        ElevatedButton(onPressed: (){
                                          _onDeleteButtonClick(pos);
                                          Navigator.pop(context);
                                        }, child: const Text("Yes"))
                                      ],
                                    );
                                  });
                                },
                                icon: const Icon(
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditDialog(context,
              "Add New Blog!",
              imageUrlController: _imageUrlController,
              titleController: _titleController,
              descriptionController: _descriptionController,
              dateController: _dateController,
              topicController: _topicController,
              blogUrlController: _blogUrlController,
              sortOrderController: _sortOrderController,
            onSubmitButtonClick: (){
              _onSubmitButtonClickForAdd();
            },
            onCancelButtonClick: _onCancelButtonClick,
            onDateSelectionTap: _onDateSelectionTap
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  // TODO: implement restorationId
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime.now(),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        _dateController.text = "${newSelectedDate.day.toString().padLeft(2,'0')}-${newSelectedDate.month.toString().padLeft(2,'0')}-${newSelectedDate.year}";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }
}
