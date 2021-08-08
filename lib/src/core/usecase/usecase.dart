import 'package:dartz/dartz.dart';
import 'package:weather_app_clean_architecture/src/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
