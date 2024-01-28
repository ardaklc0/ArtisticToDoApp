import 'package:flutter/material.dart';
import 'package:pomodoro2/ui/helper/common_variables.dart';
import 'package:provider/provider.dart';

import '../../../provider/audio_provider.dart';


class NotificationSoundWidget extends StatelessWidget {
  const NotificationSoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(242, 245, 234, 1),
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1),
            blurRadius: 2.0,
            spreadRadius: 0.05,
          ),
        ],
      ),
      child: Consumer<SoundSelectionProvider>(
          builder: (context, provider, child) {
            return DropdownButtonFormField<String>(
              dropdownColor: const Color.fromRGBO(242, 245, 234, 1),
              value: provider.selectedAudioFile,
              decoration: const InputDecoration(
                labelText: 'Notification sound',
              ),
              items: provider.audioFiles.map((audioFile) {
                return DropdownMenuItem<String>(
                  value: audioFile,
                  child: Text(
                    textAlign: TextAlign.center,
                    audioFile,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                provider.setSelectedAudioFile(value!);
              },
            );
          }),
    );
  }
}