import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicDetailsPage extends StatefulWidget {
  String? image, name, aartistName, audioURL;
  MusicDetailsPage({this.aartistName, this.audioURL, this.image, this.name});

  @override
  State<MusicDetailsPage> createState() => _MusicDetailsPageState();
}

class _MusicDetailsPageState extends State<MusicDetailsPage> {
  late AudioPlayer _audioPlayer;

  bool isPlayButton = true;

  @override
  void initState() {
    // TODO: implement initState

    _audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: StatefulBuilder(builder: (snapshot, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.image.toString(),
                        ),
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.name.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.4)),
                child: GestureDetector(
                  onTap: () async {
                    isPlayButton = !isPlayButton;
                    if (isPlayButton) {
                      await _audioPlayer.play(widget.audioURL.toString());
                    } else {
                      _audioPlayer.stop();
                    }
                    setState(() {
                      snapshot;
                    });
                  },
                  child: isPlayButton
                      ? Icon(
                          Icons.pause,
                          color: Colors.white,
                          size: 50,
                        )
                      : Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          );
        }),
      ),
    );
  }
}
