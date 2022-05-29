import 'dart:convert' as jsonconvert;
import 'package:dio/dio.dart';
import 'package:music_app/utils/interceptors/token.dart';
import '../../config/constants/api_path.dart';
import '../../models/song.dart';

class ApiClient{

  Dio _dio = Dio();
  
  // singleton approach
  static ApiClient _apiClient = ApiClient();
  _ApiClient(){}
  
  ApiClient getApiClientInstance(){
    // call interceptor
    tokenInterceptor(_dio);
    return _apiClient;
  }

  void getSongs(Function successCallBack, Function failCallBack,{String artistName = "sonu+nigam"}){
    
    //final URL = "https://itunes.apple.com/search?term=$artistName&limit=10";
    
    final URL = "${ApisPath.BASE_URL}?term=$artistName&limit=25";
    
    //Future<http.Response> future = http.get(Uri.parse(URL));

    Future<Response> future = _dio.get(URL);
    
    future.then((response){
      String json = response.data;
      // Doing JSON Conversion and Store in Song Model 
      Map<String, dynamic> map = jsonconvert.jsonDecode(json); // JSON convert into MAP
      List<dynamic> list = map['results']; // Get the List from the Map
      List<Song> songs = list.map((songMap)=> Song.fromJson(songMap)).toList();
      //print(songs);
      successCallBack(songs);
    }).catchError((err)=>failCallBack(err));

  }

}