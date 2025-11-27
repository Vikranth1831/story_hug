import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:story_hug/utils/media_query_helper.dart';

import '../../components/CommonLoader.dart';
import '../../controller/faverateController.dart';
import '../../controller/fetchStoryDetailsController.dart';
import '../../data/remote_data_source.dart';
import '../../repositories/FetchStoryDetailsRepo.dart';
import '../../repositories/faveratesRepo.dart';
import '../../utils/constants.dart';

class PlayStory extends StatefulWidget {
  const PlayStory({super.key});

  @override
  State<PlayStory> createState() => _PlayStoryState();
}

class _PlayStoryState extends State<PlayStory> {
  bool isTablet = false;
  final ValueNotifier<bool> isLikedNotifier = ValueNotifier<bool>(false);

  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<double> positionNotifier = ValueNotifier<double>(0.0);
  static const double _totalDuration = 162.0; // in seconds (2:42)
  Timer? _positionTimer;
  final FetchStoryDetailsController fetchStoryDetailsController = Get.put(
    FetchStoryDetailsController(
      fetchStoryDetailsRepo: FetchStoryDetailsImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );
  final AddToFaverateController addToFaverateController = Get.put(
    AddToFaverateController(
      faveratesListRepo: FaveratesListImpl(
        remoteDataSource: RemoteDataSourceImpl(),
      ),
    ),
  );

  late String categoryName;

  @override
  void initState() {
    super.initState();

    // ✅ Get story id from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    final String storyId = args?['storyId']?.toString() ?? '';
    categoryName = args?['catName'] ?? "Stories";
    _positionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPlayingNotifier.value) {
        final current = positionNotifier.value;
        if (current < _totalDuration) {
          positionNotifier.value = current + 1;
        } else {
          // reached end → stop
          isPlayingNotifier.value = false;
        }
      }
    });
    if (storyId.isNotEmpty) {
      fetchStoryDetailsController.fetchStoryDetails(storyId);
    } else {
      // If no id, show error and go back
      Get.snackbar("Error", "Story ID not found");
      Future.microtask(() => Get.back());
    }
  }

  @override
  void dispose() {
    _positionTimer?.cancel();
    isPlayingNotifier.dispose();
    positionNotifier.dispose();
    super.dispose();
  }

  String _formatTime(double seconds) {
    final int s = seconds.floor();
    final int m = s ~/ 60;
    final int r = s % 60;
    final String mm = m.toString();
    final String ss = r.toString().padLeft(2, '0');
    return "$mm:$ss";
  }

  @override
  Widget build(BuildContext context) {
    final double h = SizeConfig.screenHeight;
    final double w = SizeConfig.screenWidth;

    isTablet = w > 600;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimage.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: h * 0.01),

                // BACK BUTTON
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 14 : 10,
                          horizontal: isTablet ? 22 : 18,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFCDB69), Color(0xFFFCBF5D)],
                          ),
                        ),
                        child: const Text(
                          "Back",
                          style: TextStyle(
                            fontFamily: "Arial",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF24305B),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: h * 0.015),

                // LOGO
                Center(
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: isTablet ? h * 0.08 : h * 0.05,
                  ),
                ),

                SizedBox(height: h * 0.02),

                Text(
                  capitalize(categoryName),
                  style: TextStyle(
                    fontFamily: "Arial",
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: h * 0.02),

                Obx(() {
                  if (fetchStoryDetailsController.isLoading.value) {
                    return const Center(child: DottedProgressWithLogo());
                  }

                  if (fetchStoryDetailsController.errorMessage.value != null) {
                    return Center(
                      child: Text(
                        fetchStoryDetailsController.errorMessage.value!,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  final story =
                      fetchStoryDetailsController.fetchStory.value?.story;
                  isLikedNotifier.value = story?.isFavorate ?? false;
                  if (story == null) {
                    return const Center(
                      child: Text(
                        "No stories found in this category",
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    );
                  }

                  final String imageUrl = story.image ?? "";

                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                imageUrl: imageUrl,
                                width: SizeConfig.screenWidth,
                                height: isTablet ? h * 0.45 : h * 0.4,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => SizedBox(
                                  width: SizeConfig.screenWidth,
                                  height: isTablet ? h * 0.45 : h * 0.4,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: SizeConfig.screenWidth,
                                  height: isTablet ? h * 0.28 : h * 0.3,
                                  color: const Color(0xffF8FAFE),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.broken_image_outlined,
                                    size: 48,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: h * 0.03),

                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: isTablet ? 20 : 16,
                                horizontal: isTablet ? 25 : 10,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff464E8A),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  // PLAY CONTROLS
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // ⏪ Animated Backward 10s
                                      ValueListenableBuilder<double>(
                                        valueListenable: positionNotifier,
                                        builder: (context, pos, _) {
                                          return AnimatedScale(
                                            duration: const Duration(
                                              milliseconds: 150,
                                            ),
                                            scale: 1.0,
                                            child: IconButton(
                                              onPressed: () {
                                                final current =
                                                    positionNotifier.value;
                                                positionNotifier
                                                    .value = (current - 10)
                                                    .clamp(0, _totalDuration)
                                                    .toDouble();
                                              },
                                              icon: const Icon(Icons.replay_10),
                                              iconSize: isTablet ? 40 : 35,
                                              color: const Color(0xffF9E2A1),
                                            ),
                                          );
                                        },
                                      ),

                                      // ▶️⏸ Animated Play/Pause
                                      ValueListenableBuilder<bool>(
                                        valueListenable: isPlayingNotifier,
                                        builder: (context, isPlaying, _) {
                                          return GestureDetector(
                                            onTap: () {
                                              isPlayingNotifier.value =
                                                  !isPlayingNotifier.value;
                                            },
                                            child: AnimatedScale(
                                              duration: const Duration(
                                                milliseconds: 180,
                                              ),
                                              scale: isPlaying ? 1.2 : 1.0,
                                              curve: Curves.easeOutBack,
                                              child: AnimatedSwitcher(
                                                duration: const Duration(
                                                  milliseconds: 200,
                                                ),
                                                transitionBuilder:
                                                    (child, anim) =>
                                                        ScaleTransition(
                                                          scale: anim,
                                                          child: child,
                                                        ),
                                                child: Icon(
                                                  isPlaying
                                                      ? Icons
                                                            .pause_circle_filled_rounded
                                                      : Icons
                                                            .play_circle_fill_rounded,
                                                  key: ValueKey(isPlaying),
                                                  size: isTablet ? 55 : 45,
                                                  color: const Color(
                                                    0xffF9E2A1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),

                                      // ⏩ Animated Forward 10s
                                      ValueListenableBuilder<double>(
                                        valueListenable: positionNotifier,
                                        builder: (context, pos, _) {
                                          return AnimatedScale(
                                            duration: const Duration(
                                              milliseconds: 150,
                                            ),
                                            scale: 1.0,
                                            child: IconButton(
                                              onPressed: () {
                                                final current =
                                                    positionNotifier.value;
                                                positionNotifier
                                                    .value = (current + 10)
                                                    .clamp(0, _totalDuration)
                                                    .toDouble();
                                              },
                                              icon: const Icon(
                                                Icons.forward_10,
                                              ),
                                              iconSize: isTablet ? 40 : 35,
                                              color: const Color(0xffF9E2A1),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: h * 0.015),

                                  // PROGRESS SLIDER
                                  ValueListenableBuilder<double>(
                                    valueListenable: positionNotifier,
                                    builder: (context, position, _) {
                                      return Slider(
                                        value: position,
                                        min: 0,
                                        max: _totalDuration,
                                        thumbColor: const Color(0xffF9E2A1),
                                        activeColor: const Color(0xffF9E2A1),
                                        inactiveColor: Colors.white30,
                                        onChanged: (v) {
                                          positionNotifier.value = v;
                                        },
                                      );
                                    },
                                  ),

                                  // TIME LABELS
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: ValueListenableBuilder<double>(
                                      valueListenable: positionNotifier,
                                      builder: (context, position, _) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _formatTime(
                                                position,
                                              ), // current time
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              _formatTime(
                                                _totalDuration,
                                              ), // total duration
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        top: 10,
                        right: 20,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(
                              0.40,
                            ), // #000000 40% opacity
                            shape: BoxShape.circle,
                          ),
                          child: ValueListenableBuilder<bool>(
                            valueListenable: isLikedNotifier,
                            builder: (context, isLiked, _) {
                              return IconButton(
                                onPressed: () async {
                                  final newStatus = !isLikedNotifier.value;

                                  isLikedNotifier.value =
                                      newStatus; // Optimistic UI update

                                  await addToFaverateController
                                      .addToFaveratesList({
                                        "story_id": story.id,
                                        "child_id": "1",
                                      });

                                  if (addToFaverateController
                                          .errorMessage
                                          .value !=
                                      null) {
                                    // If API fails → revert UI state
                                    isLikedNotifier.value = !newStatus;
                                    Get.snackbar(
                                      "Error",
                                      "Failed to update favorite",
                                    );
                                  }
                                },
                                icon: Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: isTablet ? 40 : 32,
                                  color: const Color(0xffF9E2A1),
                                ),
                                padding: EdgeInsets.all(isTablet ? 10 : 8),
                                splashRadius: isTablet ? 30 : 25,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
