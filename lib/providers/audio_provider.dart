import 'package:flutter/foundation.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:media_booster_app/models/audio_model.dart';

class AudioProvider extends ChangeNotifier {
  final assetsAudioPlayer = AssetsAudioPlayer();
  int _currentIndex = 0;
  AudioModel? _selectedAudio;
  bool _isPaused = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  List<AudioModel> _audioList = [];

  List<AudioModel> get audioList => _audioList;

  int get currentIndex => _currentIndex;

  AudioModel? get selectedAudio => _selectedAudio;

  bool get isPaused => _isPaused;

  Duration get currentPosition => _currentPosition;

  Duration get totalDuration => _totalDuration;

  void setSelectedAudio(AudioModel audio) {
    _selectedAudio = audio;
    notifyListeners();
  }

  void setAudioList(List<AudioModel> audioList) {
    _audioList = audioList.map((audio) {
      return AudioModel(
          title: audio.title,
          description: audio.description,
          imageAsset: audio.imageAsset,
          audioAsset: audio.audioAsset);
    }).toList();

    Future.microtask(() {
      notifyListeners();
    });
  }

  bool get isPlaying => assetsAudioPlayer.isPlaying.value;

  Future<void> playAudio() async {
    if (_selectedAudio != null) {
      try {
        await assetsAudioPlayer.open(
          Audio(_selectedAudio!.audioAsset),
          autoStart: true,
          showNotification: true,
        );
        _isPaused = false;
      } on AssetsAudioPlayerError catch (e) {
        debugPrint('Error playing audio: ${e.message}');
      } catch (e) {
        debugPrint('Unexpected error: $e');
      }
    }
  }

  void pauseAudio() {
    assetsAudioPlayer.pause();
    _isPaused = true;
    notifyListeners();
  }

  void resumeAudio() {
    assetsAudioPlayer.play();
    _isPaused = false;
    notifyListeners();
  }

  void stopAudio() {
    assetsAudioPlayer.stop();
    _isPaused = false;
    notifyListeners();
  }

  void playNext() {
    if (_currentIndex < _audioList.length - 1) {
      _currentIndex++;
      setSelectedAudio(_audioList[_currentIndex]);
      playAudio();
    }
  }

  void playPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      setSelectedAudio(_audioList[_currentIndex]);
      playAudio();
    }
  }

  AudioProvider() {
    assetsAudioPlayer.realtimePlayingInfos.listen((infos) {
      _currentPosition = infos.currentPosition;
      _totalDuration = infos.duration;
      notifyListeners();
    });
  }

  void seekTo(Duration position) {
    assetsAudioPlayer.seek(position);
  }
}
