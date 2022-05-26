import 'package:dio/dio.dart';
import 'package:flutter_clean_architeture/app_moduled.dart';
import 'package:flutter_clean_architeture/modules/search/domain/entities/result_search.dart';
import 'package:flutter_clean_architeture/modules/search/domain/usecases/search_by_text.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'util/github_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();

  setUp(() {
    initModule(
      AppModule(),
      replaceBinds: [
        Bind<Dio>(
          (i) => Dio(),
        )
      ],
    );
  });

  test('Deve recuperar usecase sem erro', () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearcByTextImpl>());
  });

  test('Deve trazer uma lista de ResultSearch', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        data: githubResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final searchText = Modular.get<SearchByText>();
    final result = await searchText('pedro');

    expect(result.getOrElse(() => fail('não deve ter erros')),
        isA<List<ResultSearch>>());
  });
}
