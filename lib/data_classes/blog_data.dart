import 'package:equatable/equatable.dart';

class BlogData extends Equatable {
  final List<Blog>? indiaBlogs;
  final List<Blog>? ukBlogs;
  final String? dashboardUrl;

  BlogData({
    this.indiaBlogs,
    this.ukBlogs,
    this.dashboardUrl,
  });

  factory BlogData.fromJson(Map<String, dynamic> json) {
    return BlogData(
      indiaBlogs: json['indiaBlogs'] != null
          ? List<Blog>.from(json['indiaBlogs'].map((x) => Blog.fromJson(x)))
          : null,
      ukBlogs: json['ukBlogs'] != null
          ? List<Blog>.from(json['ukBlogs'].map((x) => Blog.fromJson(x)))
          : null,
      dashboardUrl: json['dashboardUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'indiaBlogs': indiaBlogs?.map((x) => x.toJson()).toList(),
      'ukBlogs': ukBlogs?.map((x) => x.toJson()).toList(),
      'dashboardUrl': dashboardUrl,
    };
  }

  @override
  List<Object?> get props => [indiaBlogs, ukBlogs, dashboardUrl];
}

class Blog extends Equatable {
  final String? title;
  final String? shortDesc;
  final String? bannerUrl;
  final String? blogUrl;
  final String? pubclicationDate;
  final String? topic;

  Blog({
    this.title,
    this.shortDesc,
    this.bannerUrl,
    this.blogUrl,
    this.pubclicationDate,
    this.topic,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      title: json['title'],
      shortDesc: json['shortDesc'],
      bannerUrl: json['bannerUrl'],
      blogUrl: json['blogUrl'],
      pubclicationDate: json['pubclicationDate'],
      topic: json['topic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'shortDesc': shortDesc,
      'bannerUrl': bannerUrl,
      'blogUrl': blogUrl,
      'pubclicationDate': pubclicationDate,
      'topic': topic,
    };
  }

  @override
  List<Object?> get props => [title, shortDesc, bannerUrl, blogUrl, pubclicationDate, topic];
}
