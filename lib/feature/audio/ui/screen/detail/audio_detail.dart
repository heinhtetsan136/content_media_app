import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:media_content_library/feature/audio/data/audio_model.dart';
import 'package:media_content_library/feature/audio/notifier/audio/audio_notifier.dart';
import 'package:media_content_library/feature/audio/notifier/audio_detail/audio_detail_notifier.dart';
import 'package:media_content_library/feature/audio/notifier/audio_detail/audio_detail_state_model.dart';
import 'package:media_content_library/feature/ui/widget/failed_widget.dart';

class AudioDetail extends ConsumerStatefulWidget {
  final String? id;
  AudioDetail({super.key, this.id});

  @override
  ConsumerState<AudioDetail> createState() =>
      _AudioDetailState();
}

class _AudioDetailState
    extends ConsumerState<AudioDetail> {
  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((
      _,
    ) {
      ref
          .read(audioDetailProvider.notifier)
          .getAudio(widget.id);
    });
  }

  final AudioDetailProvider audioDetailProvider =
      AudioDetailProvider(
        () => AudioDetailNotifier(),
      );
  String? _url;
  bool isLoading=true;
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    AudioDetailStateModel model = ref.watch(
      audioDetailProvider,
    );
    AudioData? audioData = model.audioData;

    ref.listen(audioDetailProvider, (
      oldState,
      newState,
    ) {
      if (newState.isSucess) {
        _loadAudio(
          newState.audioData?.url,
          context,
        );
        print(
          "object"
          '',
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          audioData?.title ?? "....Please Wait",
        ),
      ),
      body: _audioDetailBody(audioPlayer),
    );
  }

  Widget _audioDetailBody(
    AudioPlayer audioPlayer,
  ) {
    AudioDetailStateModel model = ref.watch(
      audioDetailProvider,
    );
    print(model.isLoading);
    if (model.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (model.isError) {
      return FailedWidget(
        ref: ref,
        onTry: () async {
          ref
              .read(audioDetailProvider.notifier)
              .getAudio(widget.id);
        },
      );
    }
    AudioData? audioData = model.audioData;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 500,
        ),
        child: Column(
          children: [
            Text(audioData?.artist ?? ""),
            StreamBuilder<Duration?>(
              stream: audioPlayer.positionStream,
              builder: (_, snapshot) {
                Duration current =
                    snapshot.data ??
                    Duration.zero;
                Duration length =
                    audioPlayer.duration ??
                    Duration.zero;

                double currentPosition = current
                    .inSeconds
                    .toDouble();
                double audioLength = length
                    .inSeconds
                    .toDouble();

                String displayTotal =
                    "${_displayTimeFormat(length.inMinutes)}:${_displayTimeFormat((length.inSeconds % 60).toInt())}";
                String displayCurrent =
                    "${_displayTimeFormat(current.inMinutes)}:${_displayTimeFormat((current.inSeconds % 60).toInt())}";
                return Column(
                  children: [
                    Slider(
                      value: currentPosition,
                      onChanged: (v) {
                        audioPlayer.seek(
                          Duration(
                            seconds: v.toInt(),
                          ),
                        );
                      },
                      max: audioLength,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '$displayCurrent/$displayTotal',
                    ),
                  ],
                );
              },
            ),
            StreamBuilder(
              stream:
                  audioPlayer.playerStateStream,
              builder: (_, snap) {
                PlayerState? playerState =
                    snap.data;
                bool isPlay =
                    playerState?.playing ?? false;
               isLoading= audioPlayer
                    .processingState ==
                    ProcessingState.loading;
                return  isLoading
                    ?CircularProgressIndicator()
                    : IconButton(
                        onPressed: () {
                          if (isPlay) {
                            audioPlayer.pause();
                          }



                          else if (audioPlayer
                                  .processingState ==
                              ProcessingState
                                  .ready) {
                            audioPlayer.play();
                          }
                        },
                        icon: isPlay
                            ? Icon(Icons.pause)
                            : Icon(
                                Icons
                                    .play_arrow_outlined,
                              ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _loadAudio(
    String? url,
    BuildContext context,
  ) async {
    if (url == null ||
        url.isEmpty ||
        url == _url) {
      print("url $_url && $url");
      print(
        "u rl is null or empty or same as previous",
      );
      return;
    }
    try {
      _url = url;
      print("url $_url");
      await audioPlayer.setUrl(_url ?? "");
      audioPlayer.play();
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Error"),
            content: Text("Failed to load audio"),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  String _displayTimeFormat(int time) {
    if (time < 10) {
      return "0$time";
    }
    return "$time";
  }
}
