import 'package:flutter/material.dart';
import 'package:media_booster_app/providers/audio_provider.dart';
import 'package:media_booster_app/providers/video_provider.dart';
import 'package:media_booster_app/screens/audio_detail_screen.dart';
import 'package:media_booster_app/screens/audio_n_video_screen.dart';
import 'package:media_booster_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:media_booster_app/models/video_model.dart';

void main() {
  runApp(const MediaBoosterApp());
}

class MediaBoosterApp extends StatelessWidget {
  const MediaBoosterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AudioProvider()),
        ChangeNotifierProvider(
          create: (context) => VideoProvider(
            videoAssetPaths:
                videos.map((video) => video.videoAssetPath).toList(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'splash_screen',
        routes: {
          'splash_screen': (context) => const SplashScreen(),
          '/': (context) => const AudioScreen(),
          'audio_detail': (context) => const AudioDetailScreen(),
        },
      ),
    );
  }
}
