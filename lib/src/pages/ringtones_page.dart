import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

class RingtonesPage extends StatefulWidget {
  const RingtonesPage({super.key});

  @override
  State<RingtonesPage> createState() => _RingtonesPageState();
}

class _RingtonesPageState extends State<RingtonesPage> {
  List ringtones = [];
  var player = FlutterSoundPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Material Ringtones'),
        actions: [
          FilledButton(
            child: const Text("Load ringtones"),
            onPressed: () async {
              const channel = MethodChannel('ringtone_flutter_channel');
              ringtones = await channel.invokeMethod('getRingtones');
              setState(() {});
            },
          )
        ],
      ),
      body: ringtones.isEmpty
          ? const SizedBox()
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: ringtones.length,
              itemBuilder: (context, index) {
                final ringTone = ringtones[index];
                return Card(
                  child: ListTile(
                    title: Text(ringTone.toString()),
                    onTap: () async {
                      player = (await player.openAudioSession())!;
                      player.startPlayer(
                        fromURI: '/system/media/audio/ringtones/$ringTone.ogg',
                        codec: Codec.opusOGG,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
