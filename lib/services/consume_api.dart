part of 'services.dart';

class ConsumeAPI with Setup {
  Future<ResponseAPI> get(Map<String, dynamic> param, cancelTok) async {
    try {
      Map<String, dynamic> params = {"apiKey": apiKey, "country":"us"};

      params.addAll(param);

      Response response = await dio().get("/top-headlines", queryParameters: params, cancelToken: cancelTok);

      return ResponseAPI(msg: "success", data: response.data);
    } on DioError catch (e) {
      // for print only in mode debug
      assert(() {
        print(e);
        return true;
      }());

      var msg;

      if (e.response != null){
        msg = e.response!.data['message'];
      }else {
        msg = e.message;
      }

      return ResponseAPI(msg: msg, data: null);
    }
  }
}
