import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architeture/modules/search/domain/usecases/search_by_text.dart';
import 'package:flutter_clean_architeture/modules/search/presenter/search/states/search_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final SearchByText usecase;

  SearchBloc(this.usecase) : super(SearchStart()) {
    on<String>(
      (event, emit) async {
        emit(SearchLoading());
        final result = await usecase(event);
        final state =
            result.fold((l) => SearchError(l), (r) => SearchSuccess(r));
        emit(state);
      },
      transformer: ((events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .flatMap(mapper)),
    );
  }
}
