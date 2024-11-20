import 'package:fale_por_mim/utils/app_colors.dart';
import 'package:fale_por_mim/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setLanguage('pt-BR');
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1.0
          ),
          itemCount: AppConstants.images.length + AppConstants.emotions.length,
          itemBuilder: (context, index) {
            if (index < AppConstants.images.length) {
              return GestureDetector(
                onTap: () {
                  flutterTts.speak(AppConstants.emotions[index % AppConstants.emotions.length]);
                },
                child: Card(
                  color: AppColors.getRandomColor(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppConstants.images[index],
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        AppConstants.emotions[index % AppConstants.emotions.length],
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            } else {
              int emotionIndex = index - AppConstants.images.length;
              return GestureDetector(
                onTap: () {
                  flutterTts.speak(AppConstants.bodyParts[emotionIndex]);
                },
                child: Card(
                  color: AppColors.getRandomColor(),
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Image.asset(
                              AppConstants.bodypartspain[emotionIndex],
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                        Text(
                          AppConstants.bodyParts[emotionIndex],
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}