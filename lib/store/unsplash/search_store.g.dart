// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStore, Store {
  Computed<SearchStoreState> _$stateComputed;

  @override
  SearchStoreState get state =>
      (_$stateComputed ??= Computed<SearchStoreState>(() => super.state,
              name: '_SearchStore.state'))
          .value;

  final _$_searchFutureAtom = Atom(name: '_SearchStore._searchFuture');

  @override
  ObservableFuture<List<Photo>> get _searchFuture {
    _$_searchFutureAtom.reportRead();
    return super._searchFuture;
  }

  @override
  set _searchFuture(ObservableFuture<List<Photo>> value) {
    _$_searchFutureAtom.reportWrite(value, super._searchFuture, () {
      super._searchFuture = value;
    });
  }

  final _$photosAtom = Atom(name: '_SearchStore.photos');

  @override
  ObservableList<Photo> get photos {
    _$photosAtom.reportRead();
    return super.photos;
  }

  @override
  set photos(ObservableList<Photo> value) {
    _$photosAtom.reportWrite(value, super.photos, () {
      super.photos = value;
    });
  }

  final _$pageAtom = Atom(name: '_SearchStore.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$isLastPageAtom = Atom(name: '_SearchStore.isLastPage');

  @override
  bool get isLastPage {
    _$isLastPageAtom.reportRead();
    return super.isLastPage;
  }

  @override
  set isLastPage(bool value) {
    _$isLastPageAtom.reportWrite(value, super.isLastPage, () {
      super.isLastPage = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_SearchStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$searchAsyncAction = AsyncAction('_SearchStore.search');

  @override
  Future<void> search(String query, {bool reFresh = false, int perPage = 15}) {
    return _$searchAsyncAction
        .run(() => super.search(query, reFresh: reFresh, perPage: perPage));
  }

  @override
  String toString() {
    return '''
photos: ${photos},
page: ${page},
isLastPage: ${isLastPage},
errorMessage: ${errorMessage},
state: ${state}
    ''';
  }
}
