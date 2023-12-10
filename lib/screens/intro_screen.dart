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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          if (punchlineOpacity == 0) {
            FlameAudio.play('gong.wav');
            setState(() {
              punchlineOpacity = 1;
            });
          } else {
            Navigator.of(context).pushNamed('/game');
          }
        },
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
                onEnd: () {
                  Navigator.of(context).pushNamed('/game');
                },
                child: Text(
                  Contents.introQuestion.get(),
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
