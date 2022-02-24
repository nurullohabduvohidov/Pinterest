import 'dart:convert';

import 'package:dio/dio.dart';

class DioNetwork{
  static String BASE_URL ="https://api.unsplash.com";
  static Map<String,String> headers = {
    "Content-Type":"application/json",
    "Accept-Version": "v1",
    "Authorization": "Client-ID LxwOT9qliuS5BKtfi7299ohmJzx8d13Xyx1OM7OMI6s"
  };

  static String API_PHOTO_LIST = "/photos";
  static String API_TODO_LIST_RANDOM = "/photos/random/";
  static String API_SEARCH_PHOTO = "/search/photos";
  static String API_COLLECTION_PHOTO = "/collections/photos";
  static String API_PHOTO_ONE = "/photos/"; // {ID}
  static String API_CREATE_PHOTO = "/photos";
  static String API_UPDATE_PHOTO = "/photos/"; //  {ID}
  static String API_EDIT_PHOTO = "/photos/"; //  {ID}
  static String API_DELETE_PHOTO = "/photos/"; //  {ID}


static Future<String?> GET(String api,Map<String,dynamic>? params) async {
  var options = BaseOptions(
    baseUrl: BASE_URL,
    headers: headers,
    connectTimeout: 10000,
    receiveTimeout: 3000,
  );
  Response response = await Dio(options).get(api,queryParameters: params);
  print(jsonEncode(response.data));
  if(response.statusCode == 200) return jsonEncode(response.data);
  return null;
}


  static Map<String, String> paramEmpty() {
    Map<String, String> map = {};
    return map;
  }
}