import 'package:core/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/repositories/series_repository.dart';


class GetOnAirSeries {
  final SeriesRepository repository;

  GetOnAirSeries(this.repository);

  Future<Either<Failure, List<Series>>> execute() {
    return repository.getOnAirSeries();
  }
}
