import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architeture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/search/infra/datasource/search_datasource.dart';
import 'package:flutter_clean_architeture/modules/search/infra/models/result_search_model.dart';
import 'package:flutter_clean_architeture/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchDatasourceMock extends Mock implements SearchDataSource {}

void main() {
  final dataSource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(dataSource);

  test('deve retornar uma lista de ResultSearch', () async {
    when(() => dataSource.getSearch(any()))
        .thenAnswer((_) async => <ResultSearchModel>[]);

    final result = await repository.search("abc");

    expect(result.getOrElse(() => fail('Deve ser um Right')),
        isA<List<ResultSearch>>());
  });

  test('deve retornar um erro se o datasource falhar', () async {
    when(() => dataSource.getSearch(any())).thenThrow(Exception());

    final result = await repository.search("abc");

    expect(result.fold(id, id), isA<DataSourceError>());
  });
}
