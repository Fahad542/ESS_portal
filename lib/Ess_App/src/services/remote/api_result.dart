import 'package:ess/Ess_App/src/services/remote/network_exceptions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'network_exceptions.dart';

part 'api_result.freezed.dart';

@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;

  const factory ApiResult.failure({required NetworkExceptions error}) =
      Failure<T>;

  ApiResult.error(String? reasonPhrase);
}
