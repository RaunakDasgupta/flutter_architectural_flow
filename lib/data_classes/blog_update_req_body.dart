import 'package:equatable/equatable.dart';

class BlogUpdateReqBody extends Equatable{
  final String message;
  final String base64EncodedContent;
  final String sha;

  const BlogUpdateReqBody({
    required this.message,
    required this.base64EncodedContent,
    required this.sha
  });

  Map<String, dynamic> toJson() => {
    'message': message,
    'content': base64EncodedContent,
    'sha': sha
  };

  @override
  List<Object?> get props => [message, base64EncodedContent, sha];
}