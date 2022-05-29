import 'package:dio/dio.dart';

tokenInterceptor(Dio dio){

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler){
      return handler.next(options);
    },
    onResponse: (response,handler){
      return handler.next(response);
    },
    onError: (err,handler){
      return handler.next(err);
    }
  ));

}