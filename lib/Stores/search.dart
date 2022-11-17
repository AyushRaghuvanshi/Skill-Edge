import 'package:mobx/mobx.dart';

// Include generated file
part 'search.g.dart';

// This is the class used by rest of your codebase
class Search = _Search with _$Search;

// The store-class
abstract class _Search with Store {
  @observable
  bool loading = false;

  @action
  void setLoading() {
    loading = !loading;
  }
}
