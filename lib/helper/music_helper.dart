import '../model/model.dart';

List<MusicDetails> getMusic() {
  List<MusicDetails> musics = <MusicDetails>[];

  MusicDetails musicDetails = MusicDetails();

  musicDetails.name = "Apna Bna Le";
  musicDetails.image =
      "https://lastfm.freetls.fastly.net/i/u/500x500/b38f64e1c78938c470df02d55814547b.jpg";
  musicDetails.audioUrl =
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/09/51/0d/09510dea-6579-5cd0-b13b-696abc2c520b/mzaf_10718921821360997069.plus.aac.p.m4a";
  musicDetails.artistName = "Arijit Singh";

  musics.add(musicDetails);

  //
  musicDetails = MusicDetails();
  musicDetails.name = "Ik Junoon";
  musicDetails.image =
      "https://i.scdn.co/image/ab67616d0000b2730acb5a72549287bf33b51b71";
  musicDetails.audioUrl =
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/ed/4b/1e/ed4b1ee1-bc4a-3b28-51e7-9bfbb159d109/mzaf_11558759278639663589.plus.aac.p.m4a";
  musicDetails.artistName = "Vishal Dadlani";

  musics.add(musicDetails);
  //
  musicDetails = MusicDetails();

  musicDetails.name = "Kesariya";
  musicDetails.image =
      "https://things2.do/blogs/wp-content/uploads/2022/07/kesariya-song-from-brahmastra-out-1-1.jpg";
  musicDetails.audioUrl =
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/db/a6/77/dba677db-5b64-0a2d-c19f-0f18d8fcc040/mzaf_18437633248411199823.plus.aac.p.m4a";
  musicDetails.artistName = "Arijit Singh";

  musics.add(musicDetails);

  //
  musicDetails = MusicDetails();

  musicDetails.name = "OK Jaanu";
  musicDetails.image =
      "https://stat4.bollywoodhungama.in/wp-content/uploads/2016/04/Ok-Jaanu.jpg";
  musicDetails.audioUrl =
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/b9/88/73/b98873bb-1da5-431e-0148-4221b15a589b/mzaf_15832210762398281897.plus.aac.p.m4a";
  musicDetails.artistName = "Arijit Singh";

  musics.add(musicDetails);

  ///
  musicDetails = MusicDetails();

  musicDetails.name = "Tum Se Hi";
  musicDetails.image =
      "https://i.scdn.co/image/ab67616d0000b27352fe6875028c892308ffc2f7";
  musicDetails.audioUrl =
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/f5/87/37/f58737b4-e4bd-bb63-43a1-950a65afe7a9/mzaf_12366364520962982661.plus.aac.p.m4a";
  musicDetails.artistName = "Pritam & Mohit Chauhan";

  musics.add(musicDetails);

  //
  musicDetails = MusicDetails();

  musicDetails.name = "Tu Jaane Na";
  musicDetails.image = "https://i.ytimg.com/vi/tcVKmapCIj8/maxresdefault.jpg";
  musicDetails.audioUrl =
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview126/v4/da/73/35/da733598-d75a-787f-e37f-3d758b703dd4/mzaf_14616374399370563385.plus.aac.p.m4a";
  musicDetails.artistName = "Atif Aslam";

  musics.add(musicDetails);

  //
  musicDetails = MusicDetails();

  musicDetails.name = "Tera Hone Laga Hoon";
  musicDetails.image =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlRYWu5mKugooYr2aD3ZuHd6TDD4qUCceltSGoR8BbYQ&s";
  musicDetails.audioUrl =
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/78/c2/04/78c20493-1b0b-d73d-e795-774fdc2b7182/mzaf_15738974230867815588.plus.aac.p.m4a";
  musicDetails.artistName = "Atif Aslam";

  musics.add(musicDetails);

  //
  musicDetails = MusicDetails();

  musicDetails.name = "Rubicon Drill";
  musicDetails.image =
      "https://i1.sndcdn.com/artworks-EoyOXwLzf7zVC37P-NE4pbw-t240x240.jpg";
  musicDetails.audioUrl =
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview112/v4/71/d8/7c/71d87c96-6331-b8f1-05f7-f193f9fd28c6/mzaf_16887731566938851204.plus.aac.p.m4a";
  musicDetails.artistName = "Laddi Chahal, Parmish Verma";

  musics.add(musicDetails);

  return musics;
}
