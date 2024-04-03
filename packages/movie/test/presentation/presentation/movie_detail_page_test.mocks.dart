// Mocks generated by Mockito 5.4.4 from annotations
// in movie/test/presentation/presentation/movie_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_bloc/flutter_bloc.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/bloc/movie_detail/movie_detail_bloc.dart' as _i3;
import 'package:movie/domain/usecases/usecases.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetMovieDetail_0 extends _i1.SmartFake
    implements _i2.GetMovieDetail {
  _FakeGetMovieDetail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetMovieRecommendations_1 extends _i1.SmartFake
    implements _i2.GetMovieRecommendations {
  _FakeGetMovieRecommendations_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetWatchListStatus_2 extends _i1.SmartFake
    implements _i2.GetWatchListStatus {
  _FakeGetWatchListStatus_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSaveWatchlist_3 extends _i1.SmartFake implements _i2.SaveWatchlist {
  _FakeSaveWatchlist_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRemoveWatchlist_4 extends _i1.SmartFake
    implements _i2.RemoveWatchlist {
  _FakeRemoveWatchlist_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieDetailState_5 extends _i1.SmartFake
    implements _i3.MovieDetailState {
  _FakeMovieDetailState_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieDetailBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailBloc extends _i1.Mock implements _i3.MovieDetailBloc {
  MockMovieDetailBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetMovieDetail get getMovieDetail => (super.noSuchMethod(
        Invocation.getter(#getMovieDetail),
        returnValue: _FakeGetMovieDetail_0(
          this,
          Invocation.getter(#getMovieDetail),
        ),
      ) as _i2.GetMovieDetail);

  @override
  _i2.GetMovieRecommendations get getMovieRecommendations =>
      (super.noSuchMethod(
        Invocation.getter(#getMovieRecommendations),
        returnValue: _FakeGetMovieRecommendations_1(
          this,
          Invocation.getter(#getMovieRecommendations),
        ),
      ) as _i2.GetMovieRecommendations);

  @override
  _i2.GetWatchListStatus get getWatchListStatus => (super.noSuchMethod(
        Invocation.getter(#getWatchListStatus),
        returnValue: _FakeGetWatchListStatus_2(
          this,
          Invocation.getter(#getWatchListStatus),
        ),
      ) as _i2.GetWatchListStatus);

  @override
  _i2.SaveWatchlist get saveWatchlist => (super.noSuchMethod(
        Invocation.getter(#saveWatchlist),
        returnValue: _FakeSaveWatchlist_3(
          this,
          Invocation.getter(#saveWatchlist),
        ),
      ) as _i2.SaveWatchlist);

  @override
  _i2.RemoveWatchlist get removeWatchlist => (super.noSuchMethod(
        Invocation.getter(#removeWatchlist),
        returnValue: _FakeRemoveWatchlist_4(
          this,
          Invocation.getter(#removeWatchlist),
        ),
      ) as _i2.RemoveWatchlist);

  @override
  _i3.MovieDetailState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeMovieDetailState_5(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.MovieDetailState);

  @override
  _i4.Stream<_i3.MovieDetailState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i3.MovieDetailState>.empty(),
      ) as _i4.Stream<_i3.MovieDetailState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  _i4.Future<void> onFetchMovieDetail(
    _i3.FetchMovieDetailEvent? event,
    dynamic emit,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #onFetchMovieDetail,
          [
            event,
            emit,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> onFetchMovieRecommendations(
    _i3.FetchMovieRecommendationsEvent? event,
    dynamic emit,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #onFetchMovieRecommendations,
          [
            event,
            emit,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> onFetchWatchListStatus(
    _i3.GetWatchlistStatusEvent? event,
    dynamic emit,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #onFetchWatchListStatus,
          [
            event,
            emit,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> onSaveWatchlist(
    _i3.SaveWatchlistEvent? event,
    dynamic emit,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #onSaveWatchlist,
          [
            event,
            emit,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> onRemoveWatchlist(
    _i3.RemoveWatchlistEvent? event,
    dynamic emit,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #onRemoveWatchlist,
          [
            event,
            emit,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void add(_i3.MovieDetailEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i3.MovieDetailEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i3.MovieDetailState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i3.MovieDetailEvent>(
    _i5.EventHandler<E, _i3.MovieDetailState>? handler, {
    _i5.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i5.Transition<_i3.MovieDetailEvent, _i3.MovieDetailState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void onChange(_i5.Change<_i3.MovieDetailState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
