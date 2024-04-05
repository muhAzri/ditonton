import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetSeriesDetail {
  final SeriesRepository repository;

  GetSeriesDetail(this.repository);

  Future<Either<Failure, SeriesDetail>> execute(int id) {
    return repository.getSeriesDetail(id);
  }
}
