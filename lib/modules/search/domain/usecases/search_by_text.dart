import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architeture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/search/domain/repositories/search_repository.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}

class SearcByTextImpl implements SearchByText {
  final SearchRepository repository;

  SearcByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      String searchText) async {
    if (searchText.isEmpty) {
      return Left(InvalidTextError());
    }

    return repository.search(searchText);
  }
}
