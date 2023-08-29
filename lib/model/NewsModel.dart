import 'dart:convert';

List<NewsModel> newsModelFromJson(List data) =>
    List<NewsModel>.from(data.map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  num? articleId;
  String? title;
  String? snippets;
  String? articleText;
  String? imageUrl;
  bool? isPublished;
  String? scheduled;

  NewsModel(
      {this.articleId,
      this.title,
      this.snippets,
      this.articleText,
      this.imageUrl,
      this.isPublished,
      this.scheduled});

  NewsModel.fromJson(Map<String, dynamic> json) {
    articleId = json['ArticleId'];
    title = json['Title'];
    snippets = json['Snippets'];
    articleText = json['ArticleText'];
    imageUrl = json['ImageUrl'];
    isPublished = json['IsPublished'];
    scheduled = json['Scheduled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ArticleId'] = this.articleId;
    data['Title'] = this.title;
    data['Snippets'] = this.snippets;
    data['ArticleText'] = this.articleText;
    data['ImageUrl'] = this.imageUrl;
    data['IsPublished'] = this.isPublished;
    data['Scheduled'] = this.scheduled;
    return data;
  }
}
