import 'package:flutter/material.dart';
import 'package:music_app/config/themes/color_theme.dart';
import 'package:music_app/config/themes/dark_theme.dart';
import '/screens/list_of_songs.dart';
import '/screens/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp( const MaterialApp(
    title: 'Muzic App',
    home : ListOfSongs(),
    debugShowCheckedModeBanner: false,
    //theme: getColorTheme(),
  ));
}