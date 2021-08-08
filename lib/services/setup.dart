part of 'services.dart';

mixin Setup {
  
  var options = BaseOptions(
    baseUrl: 'https://newsapi.org/v2',
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  Dio dio() => Dio(options);

  String apiKey = "d6a442f961aa43c09c2bb28c49a619ab";

}


class ResponseAPI {
  final String msg;
  final dynamic data;

  ResponseAPI({
    required this.msg,
    required this.data
  });
}

