import 'package:equatable/equatable.dart';
import 'package:flutter_architectural_flow/core/constants.dart';

class BlogJsonFileInfo extends Equatable {
  final String? sha;

  const BlogJsonFileInfo({this.sha});

  factory BlogJsonFileInfo.fromJson(Map<String, dynamic> json) {
    return BlogJsonFileInfo(
      sha: json['sha'] ?? strConstant,
    );
  }

  @override
  List<Object?> get props => [sha];
}