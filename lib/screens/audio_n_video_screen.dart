import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:media_booster_app/models/audio_model.dart';
import 'package:media_booster_app/providers/audio_provider.dart';
import 'package:media_booster_app/providers/video_provider.dart';
import 'package:media_booster_app/screens/audio_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);

    if (audioProvider.audioList.isEmpty) {
      audioProvider.setAudioList(generateAudioList());
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Media Booster',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF060320),
          elevation: 0.0,
          bottom: const TabBar(
            indicator: null,
            tabs: [
              Tab(icon: Icon(Icons.music_note), text: 'Audio'),
              Tab(icon: Icon(Icons.video_library), text: 'Video'),
            ],
          ),
        ),
        body: Container(
          color: const Color(0xFF060320),
          child: const TabBarView(
            children: [
              AudioContent(),
              VideoContent(),
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: audioProvider.selectedAudio != null
            ? Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF060320),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AudioDetailScreen(),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    color: const Color(0xFF0C1D3D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          audioProvider.selectedAudio!.imageAsset,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        audioProvider.selectedAudio!.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        audioProvider.selectedAudio!.description,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (audioProvider.isPaused)
                            IconButton(
                              iconSize: 40,
                              icon: const Icon(Icons.play_circle_filled),
                              color: Colors.deepPurpleAccent,
                              onPressed: () {
                                audioProvider.resumeAudio();
                              },
                            )
                          else
                            IconButton(
                              iconSize: 40,
                              icon: const Icon(Icons.pause_circle_filled),
                              color: Colors.deepPurpleAccent,
                              onPressed: () {
                                audioProvider.pauseAudio();
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class AudioContent extends StatelessWidget {
  const AudioContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final List<AudioModel> audioList = audioProvider.audioList;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: audioList.length,
      itemBuilder: (context, index) {
        final audio = audioList[index];
        return InkWell(
          onTap: () {
            audioProvider.setSelectedAudio(audio);
            audioProvider.playAudio();
          },
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            color: const Color(0xFF0C1D3D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  audio.imageAsset,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                audio.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                audio.description,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        );
      },
    );
  }
}

class VideoContent extends StatelessWidget {
  const VideoContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF060320),
        child: const VideoList(),
      ),
    );
  }
}

class VideoList extends StatelessWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoProvider>(context);
    final List<String> videoAssetPaths = videoProvider.videoAssetPaths;

    if (videoAssetPaths.isEmpty) {
      return const Center(
        child: Text('No videos available'),
      );
    }

    return ListView.builder(
      itemCount: videoAssetPaths.length,
      itemBuilder: (context, index) {
        final videoAssetPath = videoAssetPaths[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: VideoItem(videoAssetPath: videoAssetPath),
        );
      },
    );
  }
}

class VideoItem extends StatefulWidget {
  final String videoAssetPath;

  const VideoItem({Key? key, required this.videoAssetPath}) : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late final VideoPlayerController videoPlayerController;
  late final ChewieController chewieController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.asset(widget.videoAssetPath);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      allowedScreenSleep: false,
      showOptions: true,
      allowPlaybackSpeedChanging: true,
      draggableProgressBar: true,
      showControls: true,
      allowFullScreen: true,
      autoInitialize: true,
      showControlsOnInitialize: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GestureDetector(
        onDoubleTap: () {
          final Duration currentPosition = videoPlayerController.value.position;
          const Duration skipDuration = Duration(seconds: 10);
          videoPlayerController.seekTo(currentPosition + skipDuration);
        },
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
}
