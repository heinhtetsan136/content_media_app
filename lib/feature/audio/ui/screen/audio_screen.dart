import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/const/responsive/responsive_layout.dart';
import 'package:media_content_library/feature/audio/data/audio_model.dart';
import 'package:media_content_library/feature/audio/notifier/audio/audio_notifier.dart';
import 'package:media_content_library/feature/audio/notifier/audio/audio_state_model.dart';
import 'package:media_content_library/feature/audio/ui/screen/widget/desktop_audio_screen.dart';
import 'package:media_content_library/feature/audio/ui/screen/widget/mobile_audio_screen.dart';
import 'package:media_content_library/feature/audio/ui/widget/audio_item.dart';
import 'package:media_content_library/feature/blog/ui/widget/blog_cover_image.dart';
import 'package:media_content_library/feature/ui/widget/failed_widget.dart';

class AudioScreen extends ConsumerStatefulWidget {
  const AudioScreen({super.key});

  @override
  ConsumerState<AudioScreen> createState() =>
      _AudioScreenState();
}

class _AudioScreenState
    extends ConsumerState<AudioScreen> {
  final AudioProvider audioProvider =
      AudioProvider(() => AudioNotifier());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((
      _,
    ) {
      ref
          .read(audioProvider.notifier)
          .getAllAudio();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(
      context,
    ).colorScheme;
    AudioStateModel stateModel = ref.watch(
      audioProvider,
    );
    List<AudioData> _audiodatalist =
        ref.watch(audioProvider).model?.data ??
        [];
    if (stateModel.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (stateModel.isError) {
      return FailedWidget(
        ref: ref,
        onTry: () {
          ref
              .read(audioProvider.notifier)
              .getAllAudio();
        },
      );
    }

    return ResponsiveLayout(
      desktop: DesktopAudioScreen(  audiodatalist: _audiodatalist,
        stateModel: stateModel,
        ref: ref,
        audioProvider: audioProvider,
        colorScheme: colorScheme,),
      mobile: MobileAudioScreen(
        audiodatalist: _audiodatalist,
        stateModel: stateModel,
        ref: ref,
        audioProvider: audioProvider,
        colorScheme: colorScheme,
      ),
    );
  }
}
