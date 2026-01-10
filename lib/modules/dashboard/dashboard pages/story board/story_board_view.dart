// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:my_board/data/models/story_model.dart';
import 'package:my_board/global_controllers/global_controller.dart';

import '../../../../imports.dart';
import 'story_board_controller.dart';

class StoryBoardView extends GetView<StoryBoardController> {
  const StoryBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold2,
      bottomNavigationBar: CommonBottomNav(currentModule: 'story'),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.06,
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back_ios)),
                        SizedBox(
                          width: Get.width * 0.3,
                        ),
                        Text(
                          "Task Board",
                          style: TextStyles.text3,
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          decoration: BoxDecoration(
                              color: const Color(0xFFD0E8EC),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Center(child: Text("Get premium ")),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<StoryBoardController>(builder: (cont) {
                return cont.dataLoading
                    ? LoadingAnimation()
                    : !cont.dataLoading && cont.storyList.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.35),
                            child: Text(
                              "Empty Stories",
                              style: TextStyles.text3,
                            ),
                          )
                        : ListView.builder(
                            itemCount: cont.storyList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  cont.selectedStory = cont.storyList[index];
                                  Get.toNamed(Routes.storyBoardDetail);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 15, right: 15, top: 20),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 20.0),
                                  //height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            cont.storyList[index].title
                                                .toString(),
                                            style: TextStyles.text3!.copyWith(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                customSheet(context,
                                                    cont.storyList[index]);
                                              },
                                              child: Icon(
                                                  Icons.more_vert_outlined))
                                        ],
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Created on: ',
                                                style: TextStyles.text3!
                                                    .copyWith(
                                                        color: AppColors
                                                            .appColor)),
                                            TextSpan(
                                                text: formatDate(cont
                                                    .storyList[index].createdAt
                                                    .toString()),
                                                style: TextStyles.text3!
                                                    .copyWith(
                                                        color:
                                                            Color(0xFFA3A3A3))),
                                            TextSpan(
                                                text:
                                                    "  ${formatTime(cont.storyList[index].createdAt.toString())}",
                                                style: TextStyles.text3!
                                                    .copyWith(
                                                        color:
                                                            Color(0xFFA3A3A3))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
              }),
            )
          ],
        ),
      ),
    );
  }

  customSheet(BuildContext context, StoryModel story) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: Get.height * 0.30,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(12.0),
                topEnd: Radius.circular(12.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButtonW(
                    buttonText: "Download",
                    buttonColor: Color(0xFFD6F6FB),
                    buttonTextColor: Color(0xFF177D8C),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ElevatedButtonW(
                    buttonText: "Edit Story",
                    buttonColor: Color(0xFFD6F6FB),
                    buttonTextColor: Color(0xFF177D8C),
                    onTap: () {
                      Get.find<StoryBoardController>().selectedStory = story;
                      Get.find<StoryBoardController>().titleCtrl.text =
                          story.title!;
                      Get.find<StoryBoardController>().descriptionCtrl.text =
                          story.description!;
                      Get.toNamed(Routes.updateStoryBoard);
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ElevatedButtonW(
                    buttonText: "Delete Story",
                    buttonColor: Color(0xFFFFD5D5),
                    buttonTextColor: Color(0xFFFF1616),
                    onTap: () {
                      Get.find<StoryBoardController>()
                          .deletStory(story.sId!, context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
