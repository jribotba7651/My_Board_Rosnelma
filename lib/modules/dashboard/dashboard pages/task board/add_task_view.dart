// ignore_for_file: prefer_const_constructors

import 'package:my_board/global_controllers/global_controller.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/task%20board/task_board_controller.dart';
import '../../../../imports.dart';
import '../../../../widget/select_image_dialogue.dart';

class AddNewTaskView extends StatelessWidget {
  const AddNewTaskView({super.key});
  @override
  Widget build(BuildContext context) {
    TaskBoardController controller = Get.find<TaskBoardController>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {
              controller.addNewTask(context);
            },
            child: const Text("Add Task")),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    width: Get.width * 0.3,
                  ),
                  Text(
                    "Add Task",
                    style: TextStyles.text3,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.025,
                  ),
                  TextFormField(
                    controller: controller.titleCtrl,
                    decoration: InputDecoration(hintText: "Title"),
                    style:
                        TextStyles.text3!.copyWith(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  TextFormField(
                    controller: controller.descriptionCtrl,
                    maxLines: 8,
                    maxLength: 400,
                    decoration: InputDecoration(hintText: "Description"),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      //  controller.selectImage(ImageSource.gallery);
                      selectImageDialogue(context, () {
                        controller
                            .selectImage(ImageSource.camera, "file")
                            .then((value) {});
                      }, () {
                        controller
                            .selectImage(ImageSource.gallery, "file")
                            .then((value) {});
                      });
                    },
                    child: GetBuilder<TaskBoardController>(builder: (cont) {
                      return cont.imageFile == null
                          ? Container(
                              height: Get.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: AppColors.textFieldBackGround,
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.photo,
                                      size: Get.height * 0.08,
                                      color: AppColors.appColor,
                                    ),
                                    Text("Select Photo")
                                  ],
                                ),
                              ))
                          : SizedBox(
                              height: Get.height * 0.2,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.imageLocalPathList.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.appColor),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Image.file(
                                          controller.imageLocalPathList[index],
                                          fit: BoxFit.cover,
                                          width: Get.width - Get.width * 0.1,

                                          // Adjust width as needed
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: Get.width / 2,
                                        child: Text(
                                          '${index + 1}/${controller.imageLocalPathList.length}',
                                          style: TextStyle(
                                            color: AppColors.appColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: Get.width / 2,
                                        child: Text(
                                          '${index + 1}/${controller.imageLocalPathList.length}',
                                          style: TextStyle(
                                            color: AppColors.appColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: 10,
                                          right: Get.width / 20,
                                          child: InkWell(
                                            onTap: () {
                                              cont.removeSelectedImage(index);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              size: Get.width * 0.08,
                                              color: AppColors.appColor,
                                            ),
                                          )),
                                    ],
                                  );
                                },
                              ),
                            );
                    }),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  GetBuilder<TaskBoardController>(builder: (cont) {
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From",
                                style: TextStyles.smallText,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              InkWell(
                                onTap: () async {
                                  cont.startDate =
                                      await Get.find<GlobalController>()
                                          .showDatePickerWidget(context);
                                  cont.update();
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF6F6F6),
                                      border: Border.all(
                                          color: Color(0xFFE8E8E8), width: 1.0),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Center(
                                      child: Text(cont.startDate! == ''
                                          ? "From Date"
                                          : cont.startDate!)),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.05,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "To",
                                style: TextStyles.smallText,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              InkWell(
                                onTap: () async {
                                  cont.endDate =
                                      await Get.find<GlobalController>()
                                          .showDatePickerWidget(context);
                                  cont.update();
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF6F6F6),
                                      border: Border.all(
                                          color: Color(0xFFE8E8E8), width: 1.0),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Center(
                                      child: Text(cont.endDate! == ''
                                          ? "To Date"
                                          : cont.endDate!)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),

            // Expanded(
            //   child: RichEditor(
            //     key: Get.find<TaskBoardController>().keyEditor,
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
      ),
    );
  }
}
