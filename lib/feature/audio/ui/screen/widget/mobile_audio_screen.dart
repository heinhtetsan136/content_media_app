import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/audio_model.dart';
import '../../../notifier/audio/audio_notifier.dart';
import '../../../notifier/audio/audio_state_model.dart';
import '../../widget/audio_item.dart';

class MobileAudioScreen extends StatelessWidget {
  const MobileAudioScreen({
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
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, i) {
        if(i==_audiodatalist.length){
          if(i==stateModel.model?.total){
            return Container(
                padding: EdgeInsets.all(8),
                child: Center(child: Text("No More Data")));
          }
          if(stateModel.isPagniation==false){
            Future((){
              ref.read(audioProvider.notifier).loadMore();
            });
          }
          return Container(
              padding: EdgeInsets.all(8),
              child: Center(child: CircularProgressIndicator()));
        }
        AudioData data = _audiodatalist[i];


        return AudioItem(data: data, colorScheme: colorScheme,);

      },
      itemCount: _audiodatalist.length+1,
    );
  }
}