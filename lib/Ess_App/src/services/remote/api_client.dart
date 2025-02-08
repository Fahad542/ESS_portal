import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ess/Ess_App/src/models/api_response_models/Hod_loan_approval.dart';
import 'package:ess/Ess_App/src/models/wrappers/response_wrapper.dart';
import 'package:ess/Ess_App/src/services/local/flavor_service.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class ApiClient {
  Dio? _dio;

  final List<Interceptor>? interceptors;

  ApiClient(Dio dio, {this.interceptors}) {
    _dio = dio;
    final customHeaders = Map<String, dynamic>();
    customHeaders['Content-Type'] = 'application/json';
    customHeaders['Accept'] = 'application/json';
    _dio!
      ..options.baseUrl = FlavorService.getBaseApi

      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = customHeaders;

    if (interceptors?.isNotEmpty ?? false) {
      _dio?.interceptors.addAll(interceptors!);
    }
  }

  ResponseWrapper _response(Response? response) {
    var data = jsonDecode(response?.data);
    return ResponseWrapper(
      data: data['data'],
      message: response?.statusMessage,
      statusCode: response?.statusCode,
    );
  }

  Future<dynamic> getReq(

    String uri, {
    Map<String, dynamic>? queryParameters,
        Map<String, dynamic>? headers,
    Options? options,
    CancelToken? cancelToken,

    ProgressCallback? onReceiveProgress,
  }

  ) async {
    try {
      print(uri);
      var response = await _dio?.get(
        uri,

        queryParameters: queryParameters,
        options: Options(headers: headers),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
      // return _response(response);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getReqwithoutheader(
      String uri, {
        Map<String, dynamic>? queryParameters,

        Options? options,
        CancelToken? cancelToken,

        ProgressCallback? onReceiveProgress,
      }

      ) async {
    try {
      print(uri);
      var response = await _dio?.get(
        uri,

        queryParameters: queryParameters,

        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
      // return _response(response);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postReq(
    String uri, {
    data,

    Map<String, dynamic>? queryParameters,
    Options? options,
        Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,

  }) async {

      print("url: ${uri}");
      print("data: ${data}");
      var response = await _dio?.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),

        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print("res: ${response}");
      return response;
    // } on SocketException catch (e) {
    //   throw SocketException(e.toString());
    // } on FormatException catch (_) {
    //   throw FormatException("Unable to process the data");
    // } catch (e) {
    //   throw e;
    // }
  }

  Future<ResponseWrapper<dynamic>> patchReq(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio?.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,

      );
      return _response(response);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<ResponseWrapper<dynamic>> putReq(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio?.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return _response(response);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<ResponseWrapper<dynamic>> deleteReq(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _dio?.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _response(response);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}
