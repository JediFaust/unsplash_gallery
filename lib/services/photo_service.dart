import 'package:dio/dio.dart';
import '../models/photo.dart';
import '../utils/constants.dart';

class PhotoService {
  get http => null;

  Future<List<dynamic>> getPhotos() async {
    var dio = Dio();
    dio.interceptors.add(LogInterceptor());

    try {
      Response photoResponse = await dio.get(
        "https://api.unsplash.com/photos/?client_id=$API_KEY",
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      List<dynamic> _photos =
          photoResponse.data.map((photo) => Photo.fromJson(photo)).toList();
      return _photos;
    } catch (e) {
      return [];
    }
  }
}
