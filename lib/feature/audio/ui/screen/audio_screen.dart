import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/audio/data/audio_model.dart';
import 'package:media_content_library/feature/audio/notifier/audio_notifier.dart';
import 'package:media_content_library/feature/audio/notifier/audio_state_model.dart';
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
    final ColorScheme colorScheme=Theme.of(context).colorScheme;
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

    return ListView.builder(
      itemBuilder: (_, i) {
        AudioData data = _audiodatalist[i];
        return AudioItem(data: data, colorScheme: colorScheme);
      },
      itemCount: _audiodatalist.length,
    );

    ;
  }
}


