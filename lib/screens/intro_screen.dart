import 'dart:async';

import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:testudines_solfago/enums/contents.dart';
import 'package:testudines_solfago/enums/text_styles.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  double punchlineOpacity = 0;
  double loadingOpactiy = 0;

  Completer assetLoading = Completer();
  @override
  void initState() {
    Future.wait([
      FlameAudio.audioCache.loadAll([
        'tango.mp3',
        'wind.mp3',
        'gong.wav',
        'crecendo.wav',
        'burning.wav',
      ]),
      Flame.images.loadAllImages(),
    ]).then((value) => assetLoading.complete(value));

    super.initState();
  }

  void advance() {
    if (punchlineOpacity == 0) {
      FlameAudio.play('gong.wav');
      setState(() {
        punchlineOpacity = 1;
      });
    } else if (!assetLoading.isCompleted) {
      setState(() {
        loadingOpactiy = 1;
      });

      assetLoading.future.whenComplete(
        () => Navigator.of(context).pushNamed('/game'),
      );
    } else {
      Navigator.of(context).pushNamed('/game');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: advance,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Contents.intro.get(),
                style: TextStyles.middle.style,
              ),
              AnimatedOpacity(
                opacity: punchlineOpacity,
                duration: const Duration(seconds: 3),
                onEnd: advance,
                child: Text(
                  Contents.introQuestion.get(),
                  style: TextStyles.middle.style,
                ),
              ),
              AnimatedOpacity(
                opacity: loadingOpactiy,
                duration: const Duration(seconds: 3),
                child: Text(
                  Contents.loading.get(),
                  style: TextStyles.middle.style,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
