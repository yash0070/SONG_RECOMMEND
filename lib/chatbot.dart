import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';

// TODO import Dialogflow
DialogflowGrpcV2Beta1? dialogflow;

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  bool _isRecording = false;

  RecorderStream _recorder = RecorderStream();
  StreamSubscription? _recorderStatus;
  StreamSubscription<List<int>>? _audioStreamSubscription;
  BehaviorSubject<List<int>>? _audioStream;

  // TODO DialogflowGrpc class instance

  @override
  void initState() {
    super.initState();
    initPlugin();
  }

  @override
  void dispose() {
    _recorderStatus!.cancel();
    _audioStreamSubscription!.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    _recorderStatus = _recorder.status.listen((status) {
      if (mounted)
        setState(() {
          _isRecording = status == SoundStreamStatus.Playing;
        });
    });

    await Future.wait([_recorder.initialize()]);

    // TODO Get a Service account
    // Get a Service account
    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('assets/credentials.json'))}');
    // Create a DialogflowGrpc Instance
    dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);
  }

  void stopStream() async {
    await _recorder.stop();
    await _audioStreamSubscription!.cancel();
    await _audioStream!.close();
  }

  void handleSubmitted(text) async {
    print(text);
    _textController.clear();

    //TODO Dialogflow Code
    ChatMessage message = ChatMessage(
      text: text,
      name: "You",
      type: true,
    );

    setState(() {
      _messages.insert(0, message);
    });

    DetectIntentResponse data = await dialogflow!.detectIntent(text, 'en-US');
    String fulfillmentText = data.queryResult.fulfillmentText;
    if (fulfillmentText.isNotEmpty) {
      ChatMessage botMessage = ChatMessage(
        text: fulfillmentText,
        name: "Bot",
        type: false,
      );

      setState(() {
        _messages.insert(0, botMessage);
      });
    }
  }

  void handleStream() async {
    _recorder.start();

    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((data) {
      print(data);
      _audioStream!.add(data);
    });

    // TODO Create SpeechContexts
    var biasList = SpeechContextV2Beta1(phrases: [
      'Dialogflow CX',
      'Dialogflow Essentials',
      'Action Builder',
      'HIPAA'
    ], boost: 20.0);

    // See: https://cloud.google.com/dialogflow/es/docs/reference/rpc/google.cloud.dialogflow.v2#google.cloud.dialogflow.v2.InputAudioConfig
    var config = InputConfigV2beta1(
        encoding: 'AUDIO_ENCODING_LINEAR_16',
        languageCode: 'en-US',
        sampleRateHertz: 16000,
        singleUtterance: false,
        speechContexts: [biasList]);
    // Create an audio InputConfig

    // TODO Make the streamingDetectIntent call, with the InputConfig and the audioStream
    final responseStream =
        dialogflow!.streamingDetectIntent(config, _audioStream!);
    // TODO Get the transcript and detectedIntent and show on screen
    // Get the transcript and detectedIntent and show on screen
    responseStream.listen((data) {
      //print('----');
      setState(() {
        //print(data);
        String transcript = data.recognitionResult.transcript;
        String queryText = data.queryResult.queryText;
        String fulfillmentText = data.queryResult.fulfillmentText;

        if (fulfillmentText.isNotEmpty) {
          ChatMessage message = new ChatMessage(
            text: queryText,
            name: "You",
            type: true,
          );

          ChatMessage botMessage = new ChatMessage(
            text: fulfillmentText,
            name: "Bot",
            type: false,
          );

          _messages.insert(0, message);
          _textController.clear();
          _messages.insert(0, botMessage);
        }
        if (transcript.isNotEmpty) {
          _textController.text = transcript;
        }
      });
    }, onError: (e) {
      //print(e);
    }, onDone: () {
      //print('done');
    });
  }

  // The chat interface
  //
  //------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        Divider(height: 1.0),
        Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).accentColor),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: _textController,
                        onSubmitted: handleSubmitted,
                        decoration: InputDecoration.collapsed(
                            hintText: "Send a message"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => handleSubmitted(_textController.text),
                      ),
                    ),
                    IconButton(
                      iconSize: 30.0,
                      icon: Icon(_isRecording ? Icons.mic_off : Icons.mic),
                      onPressed: _isRecording ? stopStream : handleStream,
                    ),
                  ],
                ),
              ),
            )),
      ]),
    );
  }
}

//------------------------------------------------------------------------------------
// The chat message balloon
//
//------------------------------------------------------------------------------------
class ChatMessage extends StatefulWidget {
  ChatMessage({this.text, this.name, this.type});

  final String? text;
  final String? name;
  final bool? type;

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  late AudioPlayer _audioPlayer;
  List<SongModel>? _list = [];

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

  List<Widget> otherMessage(context) {
    if (widget.text != null) {
      print(widget.text);
      //sList<dynamic> list = jsonDecode(widget.text!);
      // print(list);
    }
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(child: new Text('B')),
      ),
      new Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.widget.name!,
                style: TextStyle(fontWeight: FontWeight.bold)),
            InkWell(
              onTap: () async {
                String? chillUrl1 =
                    "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/6c/22/e4/6c22e4e7-be30-9c39-2c7d-9714525daff8/mzaf_14871999657275460192.plus.aac.p.m4a";
                String? chillUrl2 =
                    "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/a5/37/bd/a537bd7b-f782-3cd2-b811-687b6f428cfa/mzaf_14858435388310886095.plus.aac.p.m4a";
                String? sad1 =
                    "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/78/c2/04/78c20493-1b0b-d73d-e795-774fdc2b7182/mzaf_15738974230867815588.plus.aac.p.m4a";
                String? sad2 =
                    "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/f5/87/37/f58737b4-e4bd-bb63-43a1-950a65afe7a9/mzaf_12366364520962982661.plus.aac.p.m4a";

                String? cool1 =
                    "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/78/c2/04/78c20493-1b0b-d73d-e795-774fdc2b7182/mzaf_15738974230867815588.plus.aac.p.m4a";

                String? cool2 =
                    "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/b9/88/73/b98873bb-1da5-431e-0148-4221b15a589b/mzaf_15832210762398281897.plus.aac.p.m4a";
                //  print(widget.text);
                if (widget.text!
                        .toLowerCase()
                        .compareTo("matarghasti(tamasha)") ==
                    0) {
                  await _audioPlayer.play(chillUrl2);
                }
                if (widget.text!
                        .toLowerCase()
                        .compareTo("safarnama(tamasha)") ==
                    0) {
                  await _audioPlayer.play(chillUrl1);
                }
                if (widget.text!
                        .toLowerCase()
                        .compareTo("tera hone laga hoon") ==
                    0) {
                  await _audioPlayer.play(sad1);
                }
                if (widget.text!.toLowerCase().compareTo("tum se hi") == 0) {
                  await _audioPlayer.play(sad2);
                }
                if (widget.text!.toLowerCase().compareTo("enna sona") == 0) {
                  await _audioPlayer.play(cool2);
                }
                //await _audioPlayer.play(widget.text!.toString());
                // if (widget.text!.contains(".m4a") == 0) {
                //   print(".mv4");
                // }
              },
              onDoubleTap: () async {
                await _audioPlayer.stop();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(widget.text!),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(this.widget.name!,
                style: Theme.of(context).textTheme.subtitle1),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(widget.text!),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
            child: Text(
          this.widget.name![0],
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            this.widget.type! ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}

class SongModel {
  String? songName;
  String? imageName;
  String? urll;

  SongModel({this.songName, this.imageName, this.urll});

  SongModel.fromJson(Map<String, dynamic> json) {
    songName = json['song_name'];
    imageName = json['image_name'];
    urll = json['urll'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['song_name'] = this.songName;
    data['image_name'] = this.imageName;
    data['urll'] = this.urll;
    return data;
  }
}


//https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/6c/22/e4/6c22e4e7-be30-9c39-2c7d-9714525daff8/mzaf_14871999657275460192.plus.aac.p.m4a

//https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/a5/37/bd/a537bd7b-f782-3cd2-b811-687b6f428cfa/mzaf_14858435388310886095.plus.aac.p.m4a


