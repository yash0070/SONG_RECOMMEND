import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:chat_bot/chatbot.dart';
import 'package:chat_bot/helper/music_helper.dart';
import 'package:chat_bot/model/model.dart';
import 'package:chat_bot/music_details.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MusicDetails> music = <MusicDetails>[];
  late AudioPlayer _audioPlayer;

  bool? isPlayButton = false;

  @override
  void initState() {
    // TODO: implement initState
    music = getMusic();
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
    Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    //  color: Color(0xff4169E1).withOpacity(0.8),
                    color: Color(0xffF778A1),
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [
                        // Color(0xffF778A1),
                        Color(0xff4169E1),
                        Color(0xffF778A1),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.4, 0.7],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Favourite Playlist",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: _size.height - 50,
                    child: ListView.builder(
                        itemCount: music.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => MusicDetailsPage(
                              //               image: music[index].image,
                              //               name: music[index].name,
                              //               aartistName: music[index].artistName,
                              //               audioURL: music[index].audioUrl,
                              //             )));
                              await _audioPlayer
                                  .play(music[index].audioUrl.toString());

                              setState(() {});
                            },
                            onDoubleTap: () async {
                              await _audioPlayer.stop();
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            music[index].image.toString(),
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            music[index].name.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Artist Name : " +
                                                music[index]
                                                    .artistName
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey
                                                    .withOpacity(0.7)),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //  color: Color(0xff4169E1).withOpacity(0.8),
                  color: Color(0xffF778A1),
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      // Color(0xffF778A1),
                      Color(0xff4169E1),
                      Color(0xffF778A1),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0.4, 0.7],
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: Icon(
                  Icons.chat,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // bottomNavigationBar: isPlayButton! ? bottomItem(name: ) : SizedBox(),
        ),
      ),
    );
  }

  Widget bottomItem({String? name, String? imageUrl, bool? isplay}) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    image: DecorationImage(
                        image: NetworkImage(imageUrl.toString()))),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                name.toString(),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              ),
            ],
          ),
          Icon(
            Icons.play_arrow,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class MusicContainer extends StatelessWidget {
  String? name, imageUrl, artistName, audioUrl;
  bool? isplay = false;

  MusicContainer(
      {this.name, this.imageUrl, this.audioUrl, this.artistName, this.isplay});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(
                    imageUrl.toString(),
                  ),
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Artist Name : " + artistName.toString(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.withOpacity(0.7)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
