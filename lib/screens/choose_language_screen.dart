import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:testudines_solfago/enums/languages.dart';
import 'package:testudines_solfago/enums/text_styles.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choose language - Elige lenguaje',
            style: TextStyles.middle.style,
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  language = Languages.en;
                  FlameAudio.play('gong.wav');
                  Navigator.of(context).pushNamed('/intro');
                },
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text('English', style: TextStyles.middle.style),
                ),
              ),
              const SizedBox(width: 16.0),
              GestureDetector(
                onTap: () {
                  language = Languages.es;
                  FlameAudio.play('gong.wav');
                  Navigator.of(context).pushNamed('/intro');
                },
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text('Español', style: TextStyles.middle.style),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
