// ignore_for_file: prefer_const_constructors

import 'package:my_board/modules/dashboard/dashboard%20pages/story%20board/story_board_controller.dart';
import '../../../../core/values/form_validator_constant.dart';
import '../../../../imports.dart';

import '../../../../widget/select_image_dialogue.dart';
import 'lkigai_board_controller.dart';

class UpdateLkigaiBoardView extends StatelessWidget {
  const UpdateLkigaiBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<LkigaiBoardController>();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<LkigaiBoardController>(builder: (cont) {
          return ElevatedButtonW(
              buttonText: "Update",
              isLoading: cont.postingData,
              onTap: () {
                cont.updateLkigai(context);
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
                  onChanged: (value) {
                    controller.selectedLkigai.title = value;
                  },
                  decoration: InputDecoration(
                    hintText: "Title",
                  ),
                  style:
                      TextStyles.text3!.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                TextFormField(
                  controller: controller.descriptionCtrl,
                  validator: FormValidatorConstant.commonValidator,
                  onChanged: (value) {
                    controller.selectedLkigai.description = value;
                  },
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
                          .selectImage(ImageSource.camera, "network")
                          .then((value) {});
                    }, () {
                      controller
                          .selectImage(ImageSource.gallery, "network")
                          .then((value) {});
                    });
                  },
                  child: GetBuilder<LkigaiBoardController>(builder: (cont) {
                    return SizedBox(
                      height: Get.height * 0.3,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.selectedLkigai.image!.length,
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
                                  controller.selectedLkigai.image![index],
                                  fit: BoxFit.cover,
                                  width: Get.width - Get.width * 0.1,

                                  // Adjust width as needed
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: Get.width / 2,
                                child: Text(
                                  '${index + 1}/${controller.selectedLkigai.image!.length}',
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
                                  '${index + 1}/${controller.selectedLkigai.image!.length}',
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
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
