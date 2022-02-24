import 'dart:convert';

import 'package:http/http.dart';
import 'package:pinterest/models/pinterest.dart';

class PinterestHttp{
  static String BASE_URL ="api.unsplash.com";
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

  // Methods
  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(BASE_URL, api, params);
    Response response = await get(uri, headers: headers);
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api);
    Response response = await post(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api);
    Response response = await put(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api);
    Response response = await patch(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api, params);
    Response response = await delete(uri, headers: headers);
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  // Params
  static Map<String, String> paramEmpty() {
    Map<String, String> map = {};
    return map;
  }
  static Map<String, String> randomPage(int pageNumber) {
    Map<String, String> params = {};
    params.addAll({
      "count":pageNumber.toString(),
    });
    return params;
  }

  static Map<String, String> paramsPage(int pageNumber) {
    Map<String, String> params = {};
    params.addAll({
      "page":pageNumber.toString()
    });
    return params;
  }

  static Map<String,dynamic> paramsSearch(String search,int pageNumber){
    Map<String,String> params = {};
    params.addAll({
      "page": pageNumber.toString(),
      "query": search,
    });
    return params;
  }

  static Map<String,dynamic> paramsSelect(int pageNumber,String type,){
    Map<String,String> params = {};
    params.addAll({
      "page": "$pageNumber",
      "query": type,
    });
    return params;
  }

  ///HTTP Service Parsing

  static List<Pinterest> parseSelectPage(String response){
    Map json = jsonDecode(response);
    var data = List<Pinterest>.from(json["results"].map((e) => Pinterest.fromJson(e)));
    return data;
  }
   static List<Pinterest> parseUnsplashList(String response){
    var data = pinterestFromJson(response);
    return data;
   }
  static List<Pinterest> parseResponse(String response) {
    List json = jsonDecode(response);
    List<Pinterest> photos = List<Pinterest>.from(json.map((x) => Pinterest.fromJson(x)));
    return photos;
  }
}

