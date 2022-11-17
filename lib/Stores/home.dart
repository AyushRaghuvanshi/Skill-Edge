import 'package:mobx/mobx.dart';

// Include generated file
part 'home.g.dart';

// This is the class used by rest of your codebase
class Home = _Home with _$Home;

// The store-class
abstract class _Home with Store {
  @observable
  bool loading = false;

  @action
  void setLoading() {
    loading =!loading;
  }

  
}

