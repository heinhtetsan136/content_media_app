import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/audio/ui/widget/audio_item.dart';

import '../../../data/audio_model.dart';
import '../../../notifier/audio/audio_notifier.dart';
import '../../../notifier/audio/audio_state_model.dart';

class DesktopAudioScreen extends StatefulWidget {
  const DesktopAudioScreen({
    super.key,
    required this._audiodatalist,
    required this.stateModel,
    required this.ref,
    required this.audioProvider,
    required this.colorScheme,
  });

  final List<AudioData> _audiodatalist;
  final AudioStateModel stateModel;
  final WidgetRef ref;
  final AudioProvider audioProvider;
  final ColorScheme colorScheme;

  @override
  State<DesktopAudioScreen> createState() =>
      _DesktopAudioScreenState();
}

class _DesktopAudioScreenState
    extends State<DesktopAudioScreen> {
  bool noMore = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount:
                widget._audiodatalist.length + 1,
            gridDelegate:
                SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  mainAxisExtent: 600,
                ),
            itemBuilder: (_, i) {
              if (i ==
                  widget
                      .stateModel
                      .model
                      ?.total) {
                noMore = true;
              }

              if (i ==
                  widget._audiodatalist.length) {
                if (widget
                        .stateModel
                        .isPagniation ==
                    false) {
                  Future(() {
                    widget.ref
                        .read(
                          widget
                              .audioProvider
                              .notifier,
                        )
                        .loadMore();
                  });
                }
                return SizedBox();
              }
              final model =
                  widget._audiodatalist[i];
              return AudioItem(
                isMobile: false,
                data: model,
                colorScheme: widget.colorScheme,
              );
            },
          ),
        ),
        noMore
            ? Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Center(
                  child: Text("No More Data"),
                ),
              )
            : widget.stateModel.isPagniation
            ? Container(
                padding: EdgeInsets.all(8),
                alignment: Alignment.center,
                child:
                    CircularProgressIndicator(),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
