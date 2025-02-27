class Song {
  final String title;
  final String artist;
  final String duration;
  final String imagePath;

  Song({
    required this.imagePath,
    required this.title,
    required this.artist,
    required this.duration,
  });
}

class Playlist {
  final String name;
  final String description;
  final String imagePath;
  final List<Song> songs;

  Playlist({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.songs,
  });
}

final List<Playlist> dummyPlaylists = [
  Playlist(
    name: "R&B Playlist",
    description: "Chill your mind",
    imagePath: "assets/music_assets/p1.png",
    songs: [
      Song(
        imagePath: "assets/music_assets/p1.png",
        title: "You Right",
        artist: "Doja Cat, The Weeknd",
        duration: "3:58",
      ),
      Song(
        imagePath: "assets/music_assets/p1.png",
        title: "2 AM",
        artist: "Arizona Zervas",
        duration: "3:03",
      ),

      Song(
        imagePath: "assets/music_assets/p1.png",
        title: "True Love",
        artist: "Kanye West",
        duration: "4:52",
      ),
      Song(
        imagePath: "assets/music_assets/p1.png",
        title: "True Love",
        artist: "Kanye West",
        duration: "4:52",
      ),
    ],
  ),
  Playlist(
    name: "Daily Mix 2",
    description: "Made for you",
    imagePath: "assets/music_assets/p2.png",
    songs: [
      Song(
        imagePath: "assets/music_assets/p1.png",
        title: "Blinding Lights",
        artist: "The Weeknd",
        duration: "3:22",
      ),
      Song(
        imagePath: "assets/music_assets/p1.png",
        title: "Circles",
        artist: "Post Malone",
        duration: "3:35",
      ),
      Song(
        imagePath: "assets/music_assets/p1.png",
        title: "Circles",
        artist: "Post Malone",
        duration: "3:35",
      ),
      Song(
        imagePath: "assets/music_assets/p1.png",
        title: "Circles",
        artist: "Post Malone",
        duration: "3:35",
      ),
    ],
  ),
];

final List<Song> dummyFavouriteSongs = [
  Song(
    imagePath: "assets/music_assets/p1.png",
    title: "Bye Bye",
    artist: "Marshmello, Juice WRLD",
    duration: "2:09",
  ),
  Song(
    imagePath: "assets/music_assets/p1.png",
    title: "I Like You",
    artist: "Post Malone, Doja Cat",
    duration: "4:03",
  ),
  Song(
    imagePath: "assets/music_assets/p1.png",
    title: "Fountains",
    artist: "Drake, Tems",
    duration: "3:22",
  ),
  Song(
    imagePath: "assets/music_assets/p1.png",
    title: "True Love",
    artist: "Kanye West",
    duration: "4:52",
  ),
  Song(
    imagePath: "assets/music_assets/p1.png",
    title: "True Love",
    artist: "Kanye West",
    duration: "4:52",
  ),
];
