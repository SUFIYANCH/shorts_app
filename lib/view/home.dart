import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:whitecodel_reels/whitecodel_reels.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> videoIds = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://cdn.pixabay.com/video/2019/12/22/30470-387715996_large.mp4',
    'https://cdn.pixabay.com/video/2022/04/04/112852-696272981_large.mp4',
    'https://cdn.pixabay.com/video/2023/08/28/178049-858827907_large.mp4',
    'https://cdn.pixabay.com/video/2017/01/30/7574-201681218_large.mp4',
    'https://cdn.pixabay.com/video/2022/09/28/132927-755291766_tiny.mp4',
    'https://cdn.pixabay.com/video/2022/08/13/127738-739309173_tiny.mp4',
    'https://cdn.pixabay.com/video/2020/05/15/39116-420985147_large.mp4',
    'https://cdn.pixabay.com/video/2020/04/25/37144-413256576_tiny.mp4'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WhiteCodelReels(
        key: UniqueKey(),
        context: context,
        loader: const Center(
          child: CircularProgressIndicator(),
        ),
        videoList: List.generate(
          videoIds.length,
          (index) => videoIds[index],
        ),
        isCaching: true,
        builder:
            (context, index, child, videoPlayerController, pageController) {
          return VideoReel(
            index: index,
            videoPlayerController: videoPlayerController,
            videoUrl: videoIds[index],
          );
        },
      ),
    );
  }
}

class VideoReel extends StatefulWidget {
  final int index;
  final VideoPlayerController videoPlayerController;
  final String videoUrl;

  const VideoReel({
    super.key,
    required this.index,
    required this.videoPlayerController,
    required this.videoUrl,
  });

  @override
  State<VideoReel> createState() => _VideoReelState();
}

class _VideoReelState extends State<VideoReel> {
  Color likeBtnColor = Colors.white, dislikeBtnColor = Colors.white;
  double iconSize = 30;
  TextStyle textStyle1 = const TextStyle(
    color: Colors.white,
    fontSize: 14,
  );
  int likeCount = 10;
  bool playIcon = false;
  Timer? _timer;

  bool likeBtnSwitch = false, dislikeBtnSwitch = false, subscribeSwitch = false;
  void _togglePlayPause() {
    setState(() {
      playIcon = true;
    });

    if (widget.videoPlayerController.value.isPlaying) {
      widget.videoPlayerController.pause();
    } else {
      widget.videoPlayerController.play();
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 1), () {
        setState(() {
          playIcon = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: VideoPlayer(widget.videoPlayerController),
        ),
        Center(
          child: GestureDetector(
            onTap: _togglePlayPause,
            child: AnimatedOpacity(
              opacity: playIcon ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Icon(
                widget.videoPlayerController.value.isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                size: 80,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //search btn
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                  ),
                  // menu btn
                  IconButton(
                    onPressed: () {
                      showBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: const Color(0xff1A1818),
                              width: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              color: const Color(0xff1A1818),
                                              width: double.infinity,
                                              child: const Padding(
                                                padding: EdgeInsets.all(25),
                                                child: Text(
                                                  "🎥 Its the beauty of nature.watch and enjoy the natural beauty.#natue #wild",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 25),
                                            child: Icon(
                                              Icons.notes_rounded,
                                              color: Colors.white,
                                              size: 27,
                                            ),
                                          ),
                                          Text(
                                            'Description',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 25),
                                            child: Icon(
                                              Icons.closed_caption_rounded,
                                              color: Colors.white,
                                              size: 27,
                                            ),
                                          ),
                                          Text(
                                            'Captions',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 25),
                                            child: Icon(
                                              Icons.do_not_disturb_alt_rounded,
                                              color: Colors.white,
                                              size: 27,
                                            ),
                                          ),
                                          Text(
                                            'Don\'t recommend this channel',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 25),
                                            child: Icon(
                                              Icons.outlined_flag_rounded,
                                              color: Colors.white,
                                              size: 27,
                                            ),
                                          ),
                                          Text(
                                            'Report',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 25),
                                            child: Icon(
                                              Icons.feedback_outlined,
                                              color: Colors.white,
                                              size: 27,
                                            ),
                                          ),
                                          Text(
                                            'Send feedback',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // userprofile details
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://images.squarespace-cdn.com/content/v1/61c4da8eb1b30a201b9669f2/e2e0e62f-0064-4f86-b9d8-5a55cb7110ca/Korembi-January-2024.jpg"),
                            radius: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '@natures',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: subscribeSwitch
                                      ? const Color.fromARGB(111, 158, 158, 158)
                                      : Colors.white,
                                  foregroundColor: subscribeSwitch
                                      ? Colors.white
                                      : Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12)),
                              onPressed: () {
                                setState(() {
                                  subscribeSwitch = !subscribeSwitch;
                                });
                              },
                              child: Text(
                                subscribeSwitch ? "Subscribed" : "Subscribe",
                                style: const TextStyle(fontSize: 13),
                              ))
                        ],
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: const Text(
                          "🎥 Its the beauty of nature.watch and enjoy the natural beauty.#natue #wild",
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        //like btn
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                likeBtnSwitch = !likeBtnSwitch;
                                if (likeBtnSwitch) {
                                  likeCount++;
                                } else {
                                  likeCount--;
                                }
                              });
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.thumb_up_rounded,
                                  color: !likeBtnSwitch
                                      ? likeBtnColor
                                      : Colors.blue,
                                  size: iconSize,
                                ),
                                Text(
                                  likeCount.toString(),
                                  style: textStyle1,
                                ),
                              ],
                            ),
                          ),
                        ),

                        //dislike btn
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                dislikeBtnSwitch = !dislikeBtnSwitch;
                              });
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.thumb_down_rounded,
                                  color: !dislikeBtnSwitch
                                      ? dislikeBtnColor
                                      : Colors.blue,
                                  size: iconSize,
                                ),
                                Text(
                                  'Dislike',
                                  style: textStyle1,
                                ),
                              ],
                            ),
                          ),
                        ),

                        //comment btn
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Icon(
                                  Icons.comment_rounded,
                                  color: Colors.white,
                                  size: iconSize,
                                ),
                                Text(
                                  '6',
                                  style: textStyle1,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // share btn
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: InkWell(
                            onTap: () {
                              Share.share(widget.videoUrl);
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: iconSize,
                                ),
                                Text(
                                  'Share',
                                  style: textStyle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
