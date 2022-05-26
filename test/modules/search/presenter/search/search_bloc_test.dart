import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architeture/modules/search/domain/errors/errors.dart';
import 'package:flutter_clean_architeture/modules/search/domain/usecases/search_by_text.dart';
import 'package:flutter_clean_architeture/modules/search/presenter/search/search_bloc.dart';
import 'package:flutter_clean_architeture/modules/search/presenter/search/states/search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchByTextMock extends Mock implements SearchByText {}

void main() {
  final usecase = SearchByTextMock();
  final bloc = SearchBloc(usecase);

  test('deve retornar os estados na ordem correta', () {
    when(() => usecase(any()))
        .thenAnswer((invocation) async => const Right([]));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSuccess>(),
        ]));

    bloc.add("pedro");
  });

  test('deve retornar um erro', () {
    when(() => usecase(any()))
        .thenAnswer((invocation) async => Left(InvalidTextError()));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchError>(),
        ]));

    bloc.add("pedro");
  });
}
