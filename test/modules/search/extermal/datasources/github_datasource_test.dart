import 'package:dio/dio.dart';
import 'package:flutter_clean_architeture/modules/search/extermal/datasources/github_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../util/github_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final datasource = GithubDatasource(dio);
  test('deve retornar uma lista de ResultSearchModel', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
        data: githubResponse,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final result = datasource.getSearch('abc');
    expect(result, completes);
  });
}
