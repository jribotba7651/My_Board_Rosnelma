// ignore_for_file: prefer_const_constructors

import 'package:my_board/widget/drop_down_widget.dart';

import '../../../../core/values/form_validator_constant.dart';
import '../../../../imports.dart';
import '../../../../widget/select_image_dialogue.dart';
import 'visual_board_controller.dart';

class AddVisualBoardView extends StatelessWidget {
  const AddVisualBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<VisualBoardController>();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<VisualBoardController>(builder: (cont) {
          return ElevatedButtonW(
              buttonText: "Add",
              isLoading: cont.postingData,
              onTap: () {
                cont.addNewvisual(context);
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
                  width: Get.width * 0.25,
                ),
                Text(
                  "Story Board",
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
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.025,
                ),
                DropDownListWidget(
                    items: controller.goalsList,
                    onChanged: (val) {
                      controller.selectedGoal = val!;
                    },
                    hintText: "Select Goal Type"),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextFormField(
                  controller: controller.titleCtrl,
                  validator: FormValidatorConstant.commonValidator,
                  decoration: InputDecoration(hintText: "Title"),
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
                  child: GetBuilder<VisualBoardController>(builder: (cont) {
                    return cont.imageFile == null
                        ? Container(
                            height: Get.height * 0.3,
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
                            height: Get.height * 0.3,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.imageLocalPathList.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
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
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
