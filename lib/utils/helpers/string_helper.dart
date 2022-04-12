
String convertToTrackNameFormat(String trackName){
    if(trackName.length > 50){
      StringBuffer bf = StringBuffer();
      bf.write(trackName.substring(0,36));
      bf.write(' ... ');
      bf.write(trackName.substring(trackName.length-7,trackName.length));
      return bf.toString();
    }
    else{
      return trackName;
    }
}


String convertToSeconds(String duration){
    StringBuffer sb = StringBuffer();
    sb.write(duration[0]+":");
    for(int i = 1; i < 3; i++){
      sb.write(duration[i]);
    }
    return sb.toString();
}