import 'package:http/http.dart' as http;
import 'dart:convert' as jsonconvert;
import '../../config/constants/api_path.dart';
import '../../models/song.dart';

class ApiClient{

  void getSongs(Function successCallBack, Function failCallBack,{String artistName = "sonu+nigam"}){
    
    //final URL = "https://itunes.apple.com/search?term=$artistName&limit=10";
    
    final URL = "${ApisPath.BASE_URL}?term=$artistName&limit=25";
    
    Future<http.Response> future = http.get(Uri.parse(URL));
    
    future.then((response){
      String json = response.body;
      // Doing JSON Conversion and Store in Song Model 
      Map<String, dynamic> map = jsonconvert.jsonDecode(json); // JSON convert into MAP
      List<dynamic> list = map['results']; // Get the List from the Map
      List<Song> songs = list.map((songMap)=> Song.fromJson(songMap)).toList();
      //print(songs);
      successCallBack(songs);
    }).catchError((err)=>failCallBack(err));

  }

}