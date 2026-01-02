// ignore_for_file: prefer_const_constructors

import 'package:my_board/modules/dashboard/dashboard%20pages/lkigai%20board/lkigai_board_controller.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/story%20board/story_board_controller.dart';
import '../../../../imports.dart';
import 'package:rich_editor/rich_editor.dart';

class LkiGaiBoardView extends GetView<LkigaiBoardController> {
  const LkiGaiBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios)),
                SizedBox(
                  width: Get.width * 0.25,
                ),
                Text(
                  "Passion",
                  style: TextStyles.text3,
                ),
                Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD0E8EC),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(child: Text("Get premium ")),
                )
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.025,
          ),

          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.1, horizontal: Get.width * 0.05),
            child: Container(
                height: Get.height * 0.4,
                width: Get.height * 0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/images/likgai-features.png"))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.selectedType = "Passion";
                              controller.lkigaiList.clear();
                              controller.getLkigai();
                              Get.toNamed(Routes.listLkigaiBoard,
                                  arguments: ["Passion"]);
                            },
                            child: Container(
                              height: Get.height * 0.18,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.selectedType = "Mission";
                              controller.lkigaiList.clear();
                               controller.getLkigai();
                              Get.toNamed(Routes.listLkigaiBoard,
                                  arguments: ["Mission"]);
                            },
                            child: Container(
                              height: Get.height * 0.18,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //   height: Get.height * 0.05,
                    //   width: Get.width * 0.3,
                    //   color: Colors.red,
                    // ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.selectedType = "Vocation";
                              controller.lkigaiList.clear();
                               controller.getLkigai();
                              Get.toNamed(Routes.listLkigaiBoard,
                                  arguments: ["Vocation"]);
                            },
                            child: Container(
                              height: Get.height * 0.18,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.selectedType = "Profession";
                              controller.lkigaiList.clear();
                               controller.getLkigai();
                              Get.toNamed(Routes.listLkigaiBoard,
                                  arguments: ["Profession"]);
                            },
                            child: Container(
                              height: Get.height * 0.18,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ),

          // Expanded(
          //   child: RichEditor(
          //     key: Get.find<StoryBoardController>().keyEditor,
          //     value:
          //         '<span style="color: #A9A9A9; font-size: 24px;">Title</span><br><br><span style="color: #A9A9A9; font-size: 18px;">Description</span>',
          //     editorOptions: RichEditorOptions(
          //       //  backgroundColor: Colors.blueGrey, // Editor's bg color
          //       baseTextColor: Colors.white,
          //       // editor padding
          //       padding: EdgeInsets.symmetric(horizontal: 5.0),
          //       // font name
          //       baseFontFamily: 'sans-serif',
          //       enableVideo: false,
          //       // Position of the editing bar (BarPosition.TOP or BarPosition.BOTTOM)
          //       barPosition: BarPosition.TOP,
          //     ),
          //   ),
          // )
        ]),
      ),
    );
  }
}
