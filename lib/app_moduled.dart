import 'package:dio/dio.dart';
import 'package:flutter_clean_architeture/modules/search/domain/usecases/search_by_text.dart';
import 'package:flutter_clean_architeture/modules/search/extermal/datasources/github_datasource.dart';
import 'package:flutter_clean_architeture/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:flutter_clean_architeture/modules/search/presenter/search/search_bloc.dart';
import 'package:flutter_clean_architeture/modules/search/presenter/search/search_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => Dio()),
        Bind.singleton((i) => SearchRepositoryImpl(i.get())),
        Bind.singleton((i) => SearcByTextImpl(i.get())),
        Bind.singleton((i) => GithubDatasource(i.get())),
        Bind.singleton((i) => SearchBloc(i.get())),
      ];

  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: ((context, args) => const SearchPage()),
        )
      ];
}
