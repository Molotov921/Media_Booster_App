import 'package:flutter/material.dart';

class VideoProvider extends ChangeNotifier {
  // late List<VideoPlayerController> _videoPlayerControllers;
  // List<ChewieController> _chewieControllers = []
  late List<String> videoAssetPaths; // Change variable name

  VideoProvider({required this.videoAssetPaths}) {
    // initializePlayers();
  }

//   void initializePlayers() async {
//     _videoPlayerControllers = videoAssetPaths
//         .map((assetPath) =>
//             VideoPlayerController.asset(assetPath))
//         .toList();
//
//     await Future.wait(
//         _videoPlayerControllers.map((controller) => controller.initialize()));
//
//     _chewieControllers = _videoPlayerControllers
//         .map((controller) => ChewieController(
//               videoPlayerController: controller,
//               allowedScreenSleep: false,
//               showOptions: true,
//               allowPlaybackSpeedChanging: true,
//               draggableProgressBar: true,
//               showControls: true,
//               allowFullScreen: true,
//               looping: true,
//               autoInitialize: true,
//               showControlsOnInitialize: true,
//             ))
//         .toList();
//
//     notifyListeners();
//   }
//
//   @override
//   void dispose() {
//     for (final controller in _videoPlayerControllers) {
//       controller.dispose();
//     }
//     for (final controller in _chewieControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
}
