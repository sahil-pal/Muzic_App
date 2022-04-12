
import '../utils/helpers/string_helper.dart';

class Song{

  late String artistName;
  late String trackName;
  late String image;
  late String audio;
  late String genre;
  late String duration;

  // constructor to initialise
  Song(
    {
      required this.artistName,
      required this.trackName,
      required this.image,
      required this.audio,
      required this.genre,
      required this.duration
    }
  );

  // desearialization
  Song.fromJson(Map<String,dynamic> map){
    artistName = map['artistName'];
    trackName = map['trackName'];
    image = map['artworkUrl100'];
    audio = map['previewUrl'];
    genre = map['primaryGenreName'];
    duration = convertToSeconds(map['trackTimeMillis'].toString());
  }

  // searialization
  Map<String,dynamic> toJson(){
    return {
      "artistName": artistName,
      "trackName" : trackName,
      "imageUrl" : image,
      "audioUrl" : audio,
      "genre" : genre,
      "duration" : duration
    };
  }

  @override
  String toString(){
    return "Artist : $artistName , SongName : $trackName and duration : $duration";
  }

}

