import 'package:botcasts/constants.dart';
import 'package:botcasts/models/contents.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:botcasts/shared/seek_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import '../utils/aud.dart';

class AudioScreen extends StatefulWidget {
  Content content;
  // int id;
  AudioScreen({
    Key? key,
    required this.content,
    // required this.id,
  }) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> with WidgetsBindingObserver {
  AudioPlayer player = AudioPlayer();

  // เอาไว้ทดสอบไปก่อน ตอนนี้ยังไม่มี API
  // final Map<String, String> content = {
  //   'image_url':
  //       'https://missiontothemoon.co/wp-content/uploads/2022/06/1200-%E0%B8%AD%E0%B8%AD%E0%B8%81%E0%B8%AA%E0%B8%B4%E0%B8%99%E0%B8%84%E0%B9%89%E0%B8%B2%E0%B9%83%E0%B8%AB%E0%B8%A1%E0%B9%88%E0%B8%97%E0%B8%B5%E0%B9%84%E0%B8%A3%E0%B8%AB%E0%B8%99%E0%B9%89%E0%B8%B2%E0%B8%95%E0%B8%B2%E0%B8%81%E0%B9%87%E0%B9%80%E0%B8%AB%E0%B8%A1%E0%B8%B7%E0%B8%AD%E0%B8%99%E0%B9%80%E0%B8%94%E0%B8%B4%E0%B8%A1-%E0%B9%80%E0%B8%82%E0%B9%89%E0%B8%B2%E0%B9%83%E0%B8%88%E0%B8%81%E0%B8%A5%E0%B8%A2%E0%B8%B8%E0%B8%97%E0%B8%98%E0%B9%8C-MAYA-%E0%B8%82%E0%B8%AD%E0%B8%87-Apple-1920x1008.jpg',
  //   'title': 'ออกสินค้าใหม่ทีไรหน้าตาก็เหมือนเดิม!',
  //   'speaker': 'เอวา',
  //   'audio_url':
  //       'https://botnoi-voice.s3.amazonaws.com:443/audio/764650f8ddbc55be0cb16767b90f274b6195ade830d73205fa156e75115a4659_1_20220630110430293540.m4a'
  // };

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await player
          .setAudioSource(AudioSource.uri(Uri.parse(widget.content.audioUrl)));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: bgGreyColor,
          elevation: 0,
          centerTitle: true,
          title: const Image(
            image: AssetImage('assets/logo/Font.png'),
            height: 25,
          ),
          iconTheme: IconThemeData(color: white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  widget.content.imageUrl,
                  width: 292,
                  height: 295,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 55,
                    width: 305,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            widget.content.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFFFFF),
                            ),
                            // softWrap: false,
                            // maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          widget.content.aiSpeaker,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.favorite_outline,
                    color: Color(0xFFFFFFFF),
                    size: 30,
                  )
                ],
              ),
              const SizedBox(height: 3),
              ControlButtons(player),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                        positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: player.seek,
                  );
                },
              ),
            ],
          ),
        ),
      );
}

/// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.comment),
            color: const Color(0xFFFFFFFF),
            onPressed: () => {},
          ),
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(
              Icons.replay_10,
              size: 30,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () => {
              player.seek(Duration(seconds: player.position.inSeconds - 10)),
              if (player.position.inSeconds <= 0)
                {player.seek(const Duration(seconds: 0))},
            },
          ),
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        Expanded(
          child: StreamBuilder<PlayerState>(
            stream: player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 64.0,
                  height: 64.0,
                  child: const CircularProgressIndicator(),
                );
              } else if (playing != true) {
                return IconButton(
                  icon: const Icon(Icons.play_arrow),
                  iconSize: 64.0,
                  color: const Color(0xFFFFFFFF),
                  onPressed: player.play,
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  icon: const Icon(Icons.pause),
                  iconSize: 64.0,
                  color: const Color(0xFFFFFFFF),
                  onPressed: player.pause,
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.replay),
                  iconSize: 64.0,
                  color: const Color(0xFFFFFFFF),
                  onPressed: () => player.seek(Duration.zero),
                );
              }
            },
          ),
        ),
        Expanded(
          child: IconButton(
              icon: const Icon(
                Icons.forward_10,
                color: Color(0xFFFFFFFF),
                size: 30,
              ),
              onPressed: () => {
                    player.seek(
                        Duration(seconds: player.position.inSeconds + 10)),
                    if (player.position.inSeconds >= player.duration!.inSeconds)
                      {
                        player
                            .seek(Duration(seconds: player.duration!.inSeconds))
                      },

                    // player.seek(Duration(seconds: player.position.inSeconds + 10)),
                  }),
        ),
        // Opens speed slider dialog
        Expanded(
          child: StreamBuilder<double>(
            stream: player.speedStream,
            builder: (context, snapshot) => IconButton(
              icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF))),
              onPressed: () {
                showSliderDialog(
                  context: context,
                  title: "Adjust speed",
                  divisions: 10,
                  min: 0.5,
                  max: 1.5,
                  value: player.speed,
                  stream: player.speedStream,
                  onChanged: player.setSpeed,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
