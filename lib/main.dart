import 'package:fft/mic.dart';
import 'package:flutter/material.dart';
import 'package:fftea/fftea.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FFT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter FFT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required this.title,
    super.key,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _btnFunc() {
    List<double> myData = [12.4, 12.5, 12.6, 12.7, 12.8]; //audio

    final fft = FFT(myData.length);
    final freq = fft.realFft(myData);
  }

  void _openMicDart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MicWidget()),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              child: ElevatedButton(
                onPressed: () => _openMicDart(),
                child: const Text("Microphone Recorder"),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              child: ElevatedButton(
                onPressed: () => _btnFunc(),
                child: const Text("FFTea"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
