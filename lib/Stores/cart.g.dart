// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Cart on _Cart, Store {
  late final _$loadingAtom = Atom(name: '_Cart.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$bloadingAtom = Atom(name: '_Cart.bloading', context: context);

  @override
  bool get bloading {
    _$bloadingAtom.reportRead();
    return super.bloading;
  }

  @override
  set bloading(bool value) {
    _$bloadingAtom.reportWrite(value, super.bloading, () {
      super.bloading = value;
    });
  }

  late final _$_CartActionController =
      ActionController(name: '_Cart', context: context);

  @override
  void setLoading() {
    final _$actionInfo =
        _$_CartActionController.startAction(name: '_Cart.setLoading');
    try {
      return super.setLoading();
    } finally {
      _$_CartActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setbLoading() {
    final _$actionInfo =
        _$_CartActionController.startAction(name: '_Cart.setbLoading');
    try {
      return super.setbLoading();
    } finally {
      _$_CartActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
bloading: ${bloading}
    ''';
  }
}
