import 'package:flutter_clean_architeture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/search/domain/entities/result_search.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/search/domain/repositories/search_repository.dart';
import 'package:flutter_clean_architeture/modules/search/infra/datasource/search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource dataSource;

  SearchRepositoryImpl(this.dataSource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try {
      final result = await dataSource.getSearch(searchText);
      return Right(result);
    } catch (e) {
      return Left(DataSourceError());
    }
  }
}
