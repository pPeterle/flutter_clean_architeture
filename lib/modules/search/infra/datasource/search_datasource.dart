import 'package:flutter_clean_architeture/modules/search/infra/models/result_search_model.dart';

abstract class SearchDataSource {
  Future<List<ResultSearchModel>> getSearch(String searchText);
}
