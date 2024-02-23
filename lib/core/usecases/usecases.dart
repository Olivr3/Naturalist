import 'package:dartz/dartz.dart';
import 'package:naturalista/core/error/failure.dart';

abstract class UseCase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}
