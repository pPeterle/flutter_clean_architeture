import 'package:flutter/material.dart';
import 'package:flutter_clean_architeture/modules/search/presenter/search/search_bloc.dart';
import 'package:flutter_clean_architeture/modules/search/presenter/search/states/search_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBloc bloc = Modular.get();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              onChanged: bloc.add,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Search"),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: bloc.stream,
              builder: (context, snapshot) {
                final state = bloc.state;

                if (state is SearchStart) {
                  return const Center(
                    child: Text("Digite um texto"),
                  );
                }
                if (state is SearchError) {
                  return const Center(
                    child: Text("Houve um error"),
                  );
                }
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final list = (state as SearchSuccess).list;
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: ((context, index) {
                      final item = list[index];
                      return ListTile(
                        title: Text(item.title),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item.image),
                        ),
                      );
                    }));
              },
            ),
          )
        ],
      ),
    );
  }
}
