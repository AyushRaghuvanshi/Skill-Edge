import 'package:mobx/mobx.dart';

// Include generated file
part 'courses.g.dart';

// This is the class used by rest of your codebase
class Courses = _Courses with _$Courses;

// The store-class
abstract class _Courses with Store {
  @observable
  bool loading = false;

  @action
  void setLoading() {
    loading =!loading;
  }

  
}

