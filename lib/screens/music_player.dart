import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/utils/helpers/string_helper.dart';
import 'package:music_app/widgets/song_slider.dart';
import 'package:music_app/widgets/volume_slider.dart';
import 'package:music_app/widgets/waves.dart';

import '../models/song.dart';

class MusicPlayer extends StatefulWidget {
  
  late Song song ;
  MusicPlayer(this.song);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {

  late bool isPlaying;
  late IconData songIconData;
  late int currSongIndex;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration? _duration;
  Duration? _position;
  late double _volume = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    songIconData = Icons.play_arrow;
    isPlaying = false;
    _initPlayerThings();
  }

  // initialise duration and current position in audio player
  _initPlayerThings(){
    audioPlayer.onDurationChanged.listen((Duration d) {
      //print('Max duration: $d');
      setState(() => _duration = d);
    });
    audioPlayer.onAudioPositionChanged.listen((Duration  p){
      //print('Current position: $p');
      _position = p;
      setState((){});
    });
    audioPlayer.onPlayerCompletion.listen((duration) {
        songIconData = Icons.play_circle;
        isPlaying = false;
        audioPlayer.seek(Duration(seconds: 0));
    });
     setState(() {
       
     });
  }

  // method to play/pause song
  _playPauseSong(){
    if(!isPlaying){
      songIconData = Icons.pause_circle;
      audioPlayer.play(widget.song.audio);
    }
    else{
      songIconData = Icons.play_circle;
       audioPlayer.pause();
    }
    isPlaying = !isPlaying;
    setState(() {});
  }

  void setPostionValue(double seconds){
    audioPlayer.seek(Duration(seconds: seconds.toInt()));
    setState(() {
      
    });
  }

  void setVolumeValue(double volume){
    audioPlayer.setVolume(volume);
    _volume = volume;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Music Player',style: TextStyle(fontSize: 25),),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pop();
            audioPlayer.pause();
        }, icon: Icon(Icons.arrow_back_ios))
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              //gradient: LinearGradient(colors: [Colors.orangeAccent,Colors.yellowAccent,Colors.orangeAccent,Colors.yellowAccent])
            ),
            width: deviceSize.width,
            height: deviceSize.height/3.69,
            margin: EdgeInsets.all(15),
            // child: CircleAvatar(
            //   backgroundImage: NetworkImage(widget.song.image),
            //   //child: Image.network(widget.song.image,fit: BoxFit.cover,height: deviceSize.height/2-200,),
            // ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(widget.song.image,),fit: BoxFit.contain)
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 2),
            //color: Colors.red,
            height: deviceSize.height/2.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //color: Colors.yellow,
                  margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                  child: Text(convertToTrackNameFormat(widget.song.trackName),style: GoogleFonts.oswald(fontSize: 20,color: Colors.black,letterSpacing: 1.5,fontWeight: FontWeight.bold),)
                ),
                SongSlider(_position, setPostionValue),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${_position == null ? '--:--' : '0:${_position?.inSeconds}'}"),
                      Text("${_duration == null ? '--:--' : '0:${_duration?.inSeconds}'}"),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // prev song
                    IconButton(onPressed: (){
                      
                    }, 
                      icon: Icon(Icons.skip_previous),
                      iconSize: 60,
                      color: Colors.black45,
                    ),
                    SizedBox(width: 15,),
                    // play/pause song
                    IconButton(onPressed: (){
                      _playPauseSong();
                    }, 
                      icon: Icon(songIconData),
                      iconSize: 80,
                      color: Colors.white,
                    ),
                    SizedBox(width: 15,),
                    // next song
                    IconButton(onPressed: (){
                      
                    }, 
                      icon: Icon(Icons.skip_next),
                      iconSize: 60,
                      color: Colors.black45,
                    )
                  ],
                ),
                SizedBox(height: 5,),
                VolumeSlider(_volume,setVolumeValue),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SongWaves(),
        )
        ],
      ),
    );
  }
}