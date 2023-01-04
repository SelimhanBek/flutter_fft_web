import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:microphone/microphone.dart';

class MicWidget extends StatefulWidget {
  const MicWidget({super.key});

  @override
  State<MicWidget> createState() => _MicWidgetState();
}

class _MicWidgetState extends State<MicWidget> {
  List<double> doubleData = [];
  late MicrophoneRecorder _recorder;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();

    _initRecorder();
  }

  @override
  void dispose() {
    _recorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _initRecorder() {
    // Dispose the previous recorder.
    try {
      _recorder.dispose();
    } catch (e) {}

    _recorder = MicrophoneRecorder()
      ..init()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final value = _recorder.value;
    Widget result;

    if (value.started) {
      if (value.stopped) {
        result = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {
                setState(_initRecorder);
              },
              child: const Text('Restart recorder'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
              ),
              child: OutlinedButton(
                onPressed: () async {
                  try {
                    _audioPlayer.dispose();
                  } catch (e) {}

                  var bytes = await _recorder.toBytes();
                  List<int> mydata = bytes.toList();
                  for (var i = 0; i < mydata.length; i++) {
                    double x = mydata[i].toDouble();
                    doubleData.add(x);
                  }

                  _audioPlayer = AudioPlayer();
                  await _audioPlayer.setUrl(value.recording!.url);
                  await _audioPlayer.play();
                },
                child: const Text('Play recording'),
              ),
            ),
          ],
        );
      } else {
        result = OutlinedButton(
          onPressed: () async {
            _recorder.stop();
          },
          child: const Text('Stop recording'),
        );
      }
    } else {
      result = OutlinedButton(
        onPressed: () {
          doubleData = [];
          _recorder.start();
        },
        child: const Text('Start recording'),
      );
    }

    return Scaffold(
      body: Center(
        child: result,
      ),
    );
  }
}
