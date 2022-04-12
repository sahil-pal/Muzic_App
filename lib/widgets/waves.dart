import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SongWaves extends StatelessWidget {
  const SongWaves({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaveWidget(
    config: CustomConfig(
        gradients: [
            [Colors.grey, Color.fromARGB(235, 5, 78, 102)],
            [Colors.blue.shade500, Color.fromARGB(169, 17, 93, 170)],
            [Colors.black, Color.fromARGB(7, 42, 41, 39)],
            [Colors.blue.shade300, Color.fromARGB(83, 19, 124, 176)]
        ],
        durations: [35000, 19440, 10800, 6000],
        heightPercentages: [0.60, 0.23, 0.45, 0.30],
        blur: MaskFilter.blur(BlurStyle.solid, 25),
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
    ),
    // colors: [
    //     Colors.white70,
    //     Colors.white54,
    //     Colors.white30,
    //     Colors.white24,
    // ],
    // durations: [
    //     32000,
    //     21000,
    //     18000,
    //     5000,
    // ],
    waveAmplitude: 0,
    //heightPercentages: [0.25, 0.26, 0.28, 0.31],
    size: Size(
        500,
        MediaQuery.of(context).size.height/10+2,
    ),
  );
  }
}