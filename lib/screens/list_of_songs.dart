import 'dart:async';
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/config/constants/app_constants.dart';
import 'package:music_app/config/themes/dark_theme.dart';
import 'package:music_app/screens/music_player.dart';
import 'package:music_app/utils/services/api_client.dart';
import 'package:music_app/widgets/search_appbar.dart';
import 'package:shake/shake.dart';

import '../models/song.dart';

class ListOfSongs extends StatefulWidget {
  const ListOfSongs({Key? key}) : super(key: key);

  @override
  _ListOfSongsState createState() => _ListOfSongsState();
}

class _ListOfSongsState extends State<ListOfSongs> {
  TextEditingController searchTextEditingCtrl = TextEditingController();
  AudioPlayer audioPlayer = AudioPlayer();
  ApiClient apiClient = ApiClient();
  Flushbar flushbar = Flushbar();
  late ShakeDetector detector;
  late Timer timer;
  late String searchKeyWord;
  late bool isPlaying;
  late IconData songIconData;
  late int currSongIndex;
  List<Song> allSongs = [];

  @override
  initState() {
    apiClient.getSongs(successCallBack, errorCallBack);
    searchKeyWord = "";
    isPlaying = false;
    songIconData = Icons.play_arrow;
    currSongIndex = -1;
    _initShakeFunctionality();
    _initOnStop();
  }
  
  _setSearchKeyword() {
    searchKeyWord = searchTextEditingCtrl.text;
    audioPlayer.stop();
    // search song function 
    apiClient.getSongs(successCallBack, errorCallBack,artistName: searchKeyWord.replaceAll(' ', '+'));
    currSongIndex = -1;
    setState(() {});
  }

  // on song completion initialisation
  _initOnStop(){
    audioPlayer.onPlayerCompletion.listen((duration) {
        audioPlayer.stop();
        isPlaying = false;
        songIconData = Icons.play_arrow;
        setState(() {
          
        });
    });
  }

  // shake gesture initialisation
  _initShakeFunctionality(){
    detector = ShakeDetector.autoStart(
      onPhoneShake: () {  
        Random random = Random();
        if(currSongIndex > -1){
          currSongIndex = random.nextInt(24);
          audioPlayer.play(allSongs[currSongIndex].audio);
          _playSong(currSongIndex);
        }
    });
  }

  _playSong(int index) async {
    isPlaying = true;
    songIconData = Icons.pause_circle;
    currSongIndex = index;
    setState(() {});
    await Flushbar(
      title: 'Playing : ',
      message: '${allSongs[index].trackName}',
      duration: Duration(seconds: 3),
    ).show(context);
  }

  _pauseSong(int index) async{
    isPlaying = false;
    songIconData = Icons.play_arrow;
    audioPlayer.pause();
    setState(() {});
    await Flushbar(
      title: 'Paused : ',
      message: '${allSongs[currSongIndex].trackName}',
      duration: Duration(seconds: 3),
    ).show(context);
  }


  void successCallBack(List<Song> allSongs) {
    this.allSongs = allSongs;
    setState(() {});
  }

  void errorCallBack(dynamic err) {
    print('Error : $err');
  }

  Center _showLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _getText(String text, double fsize, Color color,
      {FontWeight fontWeight = FontWeight.w600}) {
    return Text(
      text,
      style: GoogleFonts.oswald(
          fontSize: fsize,
          color: color,
          letterSpacing: 1.5,
          fontWeight: fontWeight),
    );
  }

  Widget _showSongs() {
    Size deviceSize = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: deviceSize.height, minHeight: 120),
      child: ListView.builder(
          itemBuilder: (BuildContext btx, int index) {
            return Container(
              //height: 140,
              padding: EdgeInsets.only(top: 8.0, left: 15, right: 15),
              child: ListTile(
                onTap: (){
                  // Material Page Routing
                  _pauseSong(currSongIndex);
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> MusicPlayer(allSongs[index])));
                },
                leading: Image.network(allSongs[index].image),
                tileColor: Colors.grey.shade200,
                title: _getText(allSongs[index].trackName, 14, Colors.black,),
                subtitle: _getText(
                    'By ${allSongs[index].artistName} \n${allSongs[index].duration}',
                    14,Colors.red,fontWeight: FontWeight.w400),
                trailing: IconButton(
                  onPressed: () async {
                    if (!isPlaying) {
                      int result = await audioPlayer.play(allSongs[index].audio, volume: 3);
                      if(result == AppConstants.SUCCESS){
                        _playSong(index);
                      }
                      else{
                        // analytics --> logs ( firebase analytics one of the example )
                      }
                    } else {
                      await audioPlayer.pause();
                      _pauseSong(index);
                    }
                  },
                  icon: (index == currSongIndex)
                      ? Icon(
                          songIconData,
                          size: 30,
                        )
                      : const Icon(
                          Icons.play_arrow,
                          size: 30,
                        ),
                ),
              ),
            );
          },
          itemCount: allSongs.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/9),
            child: Container(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 2),
              color: appBarBackground,
              child: SearchAppBar(searchTextEditingCtrl, _setSearchKeyword),
            )),
        body: (allSongs.length == 0) ? _showLoading() : _showSongs());
  }
}
