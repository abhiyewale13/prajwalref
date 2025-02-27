import 'package:flutter/material.dart';
import 'package:task2/presentation/music_screen/model/music_model.dart';

class PlaylistScreen extends StatelessWidget {
  final Playlist playlist;
  const PlaylistScreen({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double padding = size.width * 0.03;
    double fontSize = size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xff090D14),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(padding * 2),
                        bottomRight: Radius.circular(padding * 2),
                      ),
                      image: DecorationImage(
                        image: AssetImage(playlist.imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(padding * 2),
                          bottomRight: Radius.circular(padding * 2),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black87, Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: padding * 1.5,
                    top: padding * 2,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    right: padding * 1.5,
                    top: padding * 2,
                    child: const Icon(Icons.more_horiz, color: Colors.white),
                  ),
                  Positioned(
                    bottom: padding * 2.5,
                    left: padding * 2,
                    right: padding * 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                playlist.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSize * 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: padding * 0.8),
                              Text(
                                playlist.description,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: fontSize * 0.8,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: padding * 1.5),
                        Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: fontSize * 1.2,
                        ),
                        SizedBox(width: padding * 1.5),
                        Image.asset(
                          'assets/music_assets/play.png',
                          height: size.height * 0.12,
                          width: size.width * 0.12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: padding * 1.5),
                itemCount: playlist.songs.length,
                itemBuilder: (context, index) {
                  Song song = playlist.songs[index];
                  return ListTile(
                    leading: Image.asset(song.imagePath),
                    title: Text(
                      song.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize * 0.8,
                      ),
                    ),
                    subtitle: Text(
                      song.artist,
                      style: TextStyle(color: Colors.white54),
                    ),
                    trailing: Text(
                      song.duration,
                      style: TextStyle(color: Colors.white54),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
