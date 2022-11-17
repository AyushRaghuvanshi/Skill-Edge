import 'package:mobx/mobx.dart';

// Include generated file
part 'cart.g.dart';

// This is the class used by rest of your codebase
class Cart = _Cart with _$Cart;

// The store-class
abstract class _Cart with Store {
  @observable
  bool loading = false;

  @action
  void setLoading() {
    loading =!loading;
  }

  @observable
  bool bloading = false;

  @action
  void setbLoading() {
    bloading =!bloading;
  }

  
}

