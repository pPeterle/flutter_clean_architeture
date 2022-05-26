import 'package:flutter_clean_architeture/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  ResultSearchModel(
      {required super.image, required super.title, required super.content});

  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content, 'img': image};
  }

  static ResultSearchModel fromMap(Map<String, dynamic> map) {
    return ResultSearchModel(
      image: map['avatar_url'],
      title: map['login'],
      content: map['type'],
    );
  }
}
