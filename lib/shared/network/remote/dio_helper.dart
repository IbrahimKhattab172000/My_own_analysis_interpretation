import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

//*Here we get our data and initiate it in our main to get the data once we open the app
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

//*Helper method to get the data & static to be able to call it from anywhere
  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
}
