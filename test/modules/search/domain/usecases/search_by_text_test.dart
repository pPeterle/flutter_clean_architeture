import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architeture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/search/domain/repositories/search_repository.dart';
import 'package:flutter_clean_architeture/modules/search/domain/usecases/search_by_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

void main() {
  final repository = SearchRepositoryMock();
  final useCase = SearcByTextImpl(repository);

  test('deve retornar uma lista de result search', () async {
    when(() => repository.search(any()))
        .thenAnswer((invocation) async => const Right([]));

    final result = await useCase("test");

    expect(result.getOrElse(() => fail('Deve ser um Right')),
        isA<List<ResultSearch>>());
  });

  test('deve retornar uma exception caso o texto seja inválido', () async {
    when(() => repository.search(any())).thenAnswer(
      (_) async => const Right([]),
    );

    final result = await useCase("");
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
