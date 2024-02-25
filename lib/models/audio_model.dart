class AudioModel {
  final String title;
  final String description;
  final String imageAsset;
  final String audioAsset;

  AudioModel({
    required this.title,
    required this.description,
    required this.imageAsset,
    required this.audioAsset,
  });
}

List<AudioModel> generateAudioList() {
  return [
    AudioModel(
      title: 'Alan Walker Faded',
      description: 'Alan Walker, Iselin Solheim, ',
      imageAsset: 'assets/images/alan_walker_faded.gif',
      audioAsset: 'assets/audio/Alan_Walker_Faded.mp3',
    ),
    AudioModel(
      title: 'Alan Walker Ignite',
      description: 'Alan Walker, Julie Bergan, K-391, Seungri',
      imageAsset: 'assets/images/alan_walker_ignite.gif',
      audioAsset: 'assets/audio/Ignite.mp3',
    ),
    AudioModel(
      title: 'La Calin',
      description: 'Serhat Durmus',
      imageAsset: 'assets/images/la_calin.gif',
      audioAsset: 'assets/audio/La_Calin.mp3',
    ),
    AudioModel(
      title: 'Carol Of The Bells',
      description: 'Lindsey Stirling',
      imageAsset: 'assets/images/lindsey_stirling_carol_of_the_bells.gif',
      audioAsset: 'assets/audio/Carol_of_the_Bells.mp3',
    ),
    AudioModel(
      title: 'Who I Am',
      description: 'Alan Walker, Peder Elias, Putri Ariani',
      imageAsset: 'assets/images/who_i_am_alan_walker.gif',
      audioAsset: 'assets/audio/Alan Walker_Who_I_Am.mp3',
    ),
  ];
}
