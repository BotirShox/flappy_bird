import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/data/back.dart';
import 'package:flappy_bird/data/bird.dart';
import 'package:flappy_bird/data/land.dart';
import 'package:flappy_bird/data/pipes.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class GameApp extends FlameGame with TapDetector, HasCollisionDetection {
  GameApp();

  double speed = 200;
  late Bird _bird;
  double _timeSinceLastPipeGroup = 0;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  Future<void> onLoad() async {
    await _initSpeech();
    addAll([
      Background(),
      Land(),
      _bird = Bird(),
      PipeS(),
    ]);
  }

  Future<void> _initSpeech() async {
    _speechEnabled = await _speechToText.initialize(onError: (e) => print('ERROR $e'));
    _startListening();
  }

  void _startListening() async {
    if (_speechEnabled) {
      await _speechToText.listen(onResult: _onSpeechResult);
    } else {
      _initSpeech();
    }
  }

  Future<void> stopListening() async {
    await _speechToText.cancel();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    print('res $result');
    String newWords = result.recognizedWords.toLowerCase();
    print('LAST $_lastWords');
    newWords = newWords.replaceAll(_lastWords.toLowerCase(), '');
    print('NEW $newWords');
    _lastWords = result.recognizedWords;
    if (newWords.toLowerCase().contains('jump')) {
      _bird.fly();
    }
  }

  restartGame() {
    // _bird.reset();
     // _bird.fly();
  }

  @override
  void onTap() {
    super.onTap();
    _bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
     _timeSinceLastPipeGroup += dt;
     if (_timeSinceLastPipeGroup > 1.5) {
       add(PipeS());
       _timeSinceLastPipeGroup = 0;
    // }
  }
}
}