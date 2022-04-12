import 'package:flutter/material.dart';

class SongSlider extends StatelessWidget {
  
  Duration? currPosition;
  Function setPositionValue;
  SongSlider(this.currPosition,this.setPositionValue);

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Colors.black,
      inactiveColor: Colors.grey,
      value: (currPosition == null )? 0 : currPosition!.inSeconds.toDouble(),
      min: 0,
      //divisions: 29,
      max: 29, 
      onChanged: (double seconds){
        setPositionValue(seconds);
      }
    );
  }
}