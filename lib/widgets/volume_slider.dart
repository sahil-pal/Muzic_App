import 'package:flutter/material.dart';

class VolumeSlider extends StatelessWidget {
  
  late double volume;
  late Function setVolumeValue;
  VolumeSlider(this.volume,this.setVolumeValue);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.volume_down,color: Colors.white,size: 30,),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 2,
          ),
          child: Container(
            width: MediaQuery.of(context).size.width*0.60,
            child: Slider(
              activeColor: Colors.white,
              inactiveColor: Colors.grey.shade600,
              value: volume,
              min: 0,
              max: 10, 
              label: 'Volume',
              onChanged: (double volume){
                setVolumeValue(volume);
              }
            ),
          ),
        ),
        Icon(Icons.volume_up,color: Colors.white,size: 30,),
      ],
    );
  }
}