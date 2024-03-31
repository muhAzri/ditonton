// Mocks generated by Mockito 5.4.2 from annotations
// in ditonton/test/presentation/provider/series_detail_notifier_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/series.dart' as _i9;
import 'package:ditonton/domain/entities/series_detail.dart' as _i7;
import 'package:ditonton/domain/repositories/series_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/get_series_detail.dart' as _i4;
import 'package:ditonton/domain/usecases/get_series_recommendations.dart'
    as _i8;
import 'package:ditonton/domain/usecases/get_watchlist_series_status.dart'
    as _i10;
import 'package:ditonton/domain/usecases/remove_series_watchlist.dart' as _i12;
import 'package:ditonton/domain/usecases/save_series_watchlist.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSeriesRepository_0 extends _i1.SmartFake
    implements _i2.SeriesRepository {
  _FakeSeriesRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetSeriesDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesDetail extends _i1.Mock implements _i4.GetSeriesDetail {
  MockGetSeriesDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.SeriesDetail>> execute(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, _i7.SeriesDetail>>.value(
                _FakeEither_1<_i6.Failure, _i7.SeriesDetail>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.SeriesDetail>>);
}

/// A class which mocks [GetSeriesRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesRecommendations extends _i1.Mock
    implements _i8.GetSeriesRecommendations {
  MockGetSeriesRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.Series>>> execute(dynamic id) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i9.Series>>>.value(
                _FakeEither_1<_i6.Failure, List<_i9.Series>>(
          this,
          Invocation.method(
            #execute,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i9.Series>>>);
}

/// A class which mocks [GetWatchListSeriesStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListSeriesStatus extends _i1.Mock
    implements _i10.GetWatchListSeriesStatus {
  MockGetWatchListSeriesStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i5.Future<bool> execute(int? id) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [id],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [SaveSeriesWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveSeriesWatchlist extends _i1.Mock
    implements _i11.SaveSeriesWatchlist {
  MockSaveSeriesWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.SeriesDetail? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [series],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [series],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveSeriesWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveSeriesWatchlist extends _i1.Mock
    implements _i12.RemoveSeriesWatchlist {
  MockRemoveSeriesWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SeriesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSeriesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.SeriesDetail? series) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [series],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, String>>.value(
            _FakeEither_1<_i6.Failure, String>(
          this,
          Invocation.method(
            #execute,
            [series],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, String>>);
}
