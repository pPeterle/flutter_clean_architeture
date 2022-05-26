import 'package:dio/dio.dart';
import 'package:flutter_clean_architeture/modules/search/infra/datasource/search_datasource.dart';
import 'package:flutter_clean_architeture/modules/search/infra/models/result_search_model.dart';

class GithubDatasource implements SearchDataSource {
  final Dio dio;

  GithubDatasource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio.get(
        'https://api.github.com/search/users?q=${_normalizeText(searchText)}');

    if (response.statusCode == 200) {
      final list = (response.data['items'] as List)
          .map(
            (item) => ResultSearchModel.fromMap(item),
          )
          .toList();

      return list;
    }

    return [];
  }

  String _normalizeText(String searchText) {
    return searchText.replaceAll(" ", "+");
  }
}
