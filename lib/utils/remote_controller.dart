import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

final _player = AudioPlayer();
void Function()? _onNext;
void Function()? _onPrevious;

// Connect a audio bluetooth device with playback controls, like one TWS earphones and use the
// onNext callback to listen to play, pause or click events, and onPrevious to listen to skipToNext.
class RemoteController {
  RemoteController._();

  static init() async {
    await AudioService.init<_MyAudioHandler>(
      builder: () => _MyAudioHandler(),
      config: const AudioServiceConfig(),
    );
    _player.play();
  }

  // Called for every play, pause or click event (like single click on a TWS earphone).
  static void onNext(void Function() callback) {
    _onNext = callback;
  }

  // Called for every skipToNext event (like double click on a TWS earphone).
  static void onPrevious(void Function() callback) {
    _onPrevious = callback;
  }
}

class _MyAudioHandler extends BaseAudioHandler {
  _MyAudioHandler() {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
  }

  @override
  Future<void> play() async {
    print('play');
    _onNext?.call();
    _player.play();
  }

  @override
  Future<void> pause() async {
    print('pause');
    _onNext?.call();
    _player.pause();
  }

  @override
  Future<void> click([MediaButton button = MediaButton.media]) async {
    print(button);
    _onNext?.call();
  }

  @override
  Future<void> skipToNext() async {
    print('skipToNext');
    _onPrevious?.call();
  }

  /// Transform a just_audio event into an audio_service state.
  ///
  /// This method is used from the constructor. Every event received from the
  /// just_audio player will be transformed into an audio_service state so that
  /// it can be broadcast to audio_service clients.
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.skipToNext,
        MediaControl.skipToPrevious,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
