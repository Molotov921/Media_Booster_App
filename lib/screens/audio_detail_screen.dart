import 'package:flutter/material.dart';
import 'package:media_booster_app/providers/audio_provider.dart';
import 'package:provider/provider.dart';

class AudioDetailScreen extends StatelessWidget {
  const AudioDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final selectedAudio = audioProvider.selectedAudio!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF060320),
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 40,
              color: Colors.white70,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFF060320),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Container(
                  width: 370,
                  height: 360,
                  decoration: BoxDecoration(
                    color: const Color(0xFF060320),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      selectedAudio.imageAsset,
                      width: 370,
                      height: 360,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    selectedAudio.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    selectedAudio.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Slider(
                      value: audioProvider.currentPosition.inMilliseconds
                          .toDouble(),
                      min: 0,
                      max:
                          audioProvider.totalDuration.inMilliseconds.toDouble(),
                      onChanged: (value) {
                        audioProvider
                            .seekTo(Duration(milliseconds: value.toInt()));
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 24.5, right: 274.5),
                        child: Text(
                          '${audioProvider.currentPosition.inMinutes}:${(audioProvider.currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
                          style:
                              const TextStyle(color: Colors.deepPurpleAccent),
                        ),
                      ),
                      Text(
                        '${audioProvider.totalDuration.inMinutes}:${(audioProvider.totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(color: Colors.deepPurpleAccent),
                      ),
                    ],
                  ),
                  if (audioProvider.audioList.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.skip_previous,
                            size: 45,
                            color: audioProvider.currentIndex == 0
                                ? Colors.grey
                                : Colors.deepPurpleAccent,
                          ),
                          onPressed: audioProvider.currentIndex == 0
                              ? null
                              : () {
                                  audioProvider.playPrevious();
                                },
                        ),
                        IconButton(
                          icon: audioProvider.isPlaying
                              ? const Icon(
                                  Icons.pause_circle_filled,
                                  color: Colors.deepPurpleAccent,
                                  size: 45,
                                )
                              : const Icon(
                                  Icons.play_circle_filled,
                                  color: Colors.deepPurpleAccent,
                                  size: 45,
                                ),
                          onPressed: () {
                            if (audioProvider.isPlaying) {
                              audioProvider.pauseAudio();
                            } else {
                              audioProvider.resumeAudio();
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.skip_next,
                            size: 45,
                            color: audioProvider.currentIndex ==
                                        audioProvider.audioList.length - 1 ||
                                    audioProvider.audioList.isEmpty
                                ? Colors.grey
                                : Colors.deepPurpleAccent,
                          ),
                          onPressed: audioProvider.currentIndex ==
                                      audioProvider.audioList.length - 1 ||
                                  audioProvider.audioList.isEmpty
                              ? null
                              : () {
                                  audioProvider.playNext();
                                },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
