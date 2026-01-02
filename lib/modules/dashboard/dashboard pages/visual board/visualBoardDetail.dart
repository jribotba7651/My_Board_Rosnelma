// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:my_board/imports.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/story%20board/story_board_controller.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/visual%20board/visual_board_controller.dart';

class VisualDetailView extends StatelessWidget {
  const VisualDetailView({Key? key});

  @override
  Widget build(BuildContext context) {
    VisualBoardController controller = Get.find<VisualBoardController>();
    return Scaffold(
      // bottomNavigationBar: Container(
      //   height: Get.height * 0.10,
      //   color: Colors.white,
      //   child: Center(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 15.0),
      //       child: ElevatedButtonW(
      //         buttonText: "Edit Story",
      //         onTap: () {
      //           controller.titleCtrl.text = controller.selectedStory.title!;
      //           controller.descriptionCtrl.text =
      //               controller.selectedStory.description!;
      //           Get.toNamed(Routes.updateStoryBoard);
      //           //  Get.toNamed(Routes.addStoryBoard);
      //         },
      //       ),
      //     ),
      //   ),
      // ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: const Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.selectedDeatilGoal.image!.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        FutureBuilder(
                          future: precacheImage(
                            NetworkImage(
                                controller.selectedDeatilGoal.image![index]),
                            context,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        controller.selectedDeatilGoal.image![index]),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                width: Get.width, // Adjust width as needed
                              );
                            } else {
                              return SizedBox(
                                width: Get.width,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.appColor,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          left: Get.width / 2,
                          child: Text(
                            '${index + 1}/${controller.selectedDeatilGoal.image!.length}',
                            style: TextStyle(
                              color: AppColors.appColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.02,
                  horizontal: Get.width * 0.02,
                ),
                child: Text(
                  controller.selectedDeatilGoal.title ?? "No Title",
                  style: TextStyles.h2,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                child: Text(
                  controller.selectedDeatilGoal.description ?? "No Title",
                  style: TextStyles.smallText!
                      .copyWith(fontWeight: FontWeight.w300),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
