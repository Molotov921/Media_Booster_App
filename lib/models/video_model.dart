class VideoModel {
  final String id;
  final String title;
  final String description;
  final String videoAssetPath;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoAssetPath,
  });
}

final List<VideoModel> videos = [
  VideoModel(
      id: '1',
      title: 'Video 1',
      description: 'Description of Video 1',
      videoAssetPath: 'assets/videos/video1.mp4'),
  VideoModel(
      id: '2',
      title: 'Video 2',
      description: 'Description of Video 2',
      videoAssetPath: 'assets/videos/video2.mp4'),
  VideoModel(
      id: '3',
      title: 'Video 3',
      description: 'Description of Video 3',
      videoAssetPath: 'assets/videos/video3.mp4'),
  VideoModel(
      id: '4',
      title: 'Video 4',
      description: 'Description of Video 4',
      videoAssetPath: 'assets/videos/video4.mp4'),
  VideoModel(
      id: '5',
      title: 'Video 5',
      description: 'Description of Video 5',
      videoAssetPath: 'assets/videos/video5.mp4'),
];
