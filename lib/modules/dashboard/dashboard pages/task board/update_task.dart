// ignore_for_file: prefer_const_constructors

import '../../../../core/values/form_validator_constant.dart';
import '../../../../global_controllers/global_controller.dart';
import '../../../../imports.dart';
import '../../../../widget/select_image_dialogue.dart';
import 'task_board_controller.dart';

class UpdateTaskBoardView extends StatelessWidget {
  const UpdateTaskBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<TaskBoardController>();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<TaskBoardController>(builder: (cont) {
          return ElevatedButtonW(
              buttonText: "Update",
              isLoading: cont.postingData,
              onTap: () {
                cont.updateTask(context);
              });
        }),
      ),
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
                  width: Get.width * 0.26,
                ),
                Text(
                  "Edit Story",
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.025,
                ),
                TextFormField(
                  controller: controller.titleCtrl,
                  decoration: InputDecoration(
                    hintText: "Title",
                  ),
                  onChanged: (value) {
                    controller.selectedTask.title = value;
                  },
                  style:
                      TextStyles.text3!.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextFormField(
                  controller: controller.descriptionCtrl,
                  validator: FormValidatorConstant.commonValidator,
                  maxLines: 8,
                  maxLength: 400,
                  decoration: InputDecoration(hintText: "Description"),
                  onChanged: (value) {
                    controller.selectedTask.description = value;
                  },
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),

                InkWell(
                  onTap: () {
                    //  controller.selectImage(ImageSource.gallery);
                    selectImageDialogue(context, () {
                      controller
                          .selectImage(ImageSource.camera, "network")
                          .then((value) {});
                    }, () {
                      controller
                          .selectImage(ImageSource.gallery, "network")
                          .then((value) {});
                    });
                  },
                  child: GetBuilder<TaskBoardController>(builder: (cont) {
                    return SizedBox(
                      height: Get.height * 0.25,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.selectedTask.image!.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.appColor),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Image.network(
                                  controller.selectedTask.image![index],
                                  fit: BoxFit.cover,
                                  width: Get.width - Get.width * 0.1,

                                  // Adjust width as needed
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: Get.width / 2,
                                child: Text(
                                  '${index + 1}/${controller.selectedTask.image!.length}',
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
                                  '${index + 1}/${controller.selectedTask.image!.length}',
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
                                      cont.removeSelectedStoryImage(index);
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
                // InkWell(
                //   onTap: () {
                //     //  controller.selectImage(ImageSource.gallery);
                //     selectImageDialogue(context, () {
                //       controller
                //           .selectImage(ImageSource.camera)
                //           .then((value) {});
                //     }, () {
                //       controller
                //           .selectImage(ImageSource.gallery)
                //           .then((value) {});
                //     });
                //   },
                //   child: GetBuilder<TaskBoardController>(builder: (cont) {
                //     return cont.imageFile == null
                //         ? Container(
                //             height: Get.height * 0.25,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(8.0),
                //                 color: AppColors.textFieldBackGround,
                //                 image: DecorationImage(
                //                     image: NetworkImage(
                //                         cont.selectedTask.image![0]),
                //                     fit: BoxFit.fill)),
                //           )
                //         : Container(
                //             height: Get.height * 0.25,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(8.0),
                //                 color: AppColors.textFieldBackGround,
                //                 image: DecorationImage(
                //                     image: FileImage(cont.imageFile!),
                //                     fit: BoxFit.cover)),
                //           );
                //   }),
                // ),
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
                                cont.selectedTask.startedOn = cont.startDate;
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
                                cont.selectedTask.deadline = cont.endDate;
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
          )
        ]),
      ),
    );
  }
}
