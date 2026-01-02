// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:my_board/data/models/lkigai_model.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/lkigai%20board/lkigai_board_controller.dart';

import '../../../../imports.dart';

class LkigaiListView extends StatelessWidget {
  const LkigaiListView({super.key});

  @override
  Widget build(BuildContext context) {
    LkigaiBoardController controller = Get.find<LkigaiBoardController>();
    return Scaffold(
      backgroundColor: AppColors.scaffold2,
      bottomNavigationBar: Container(
        height: Get.height * 0.10,
        color: Colors.white,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ElevatedButtonW(
              buttonText: "Create ${controller.selectedType}",
              onTap: () {
                controller.titleCtrl.clear();
                controller.descriptionCtrl.clear();
                controller.imageFile = null;
                controller.imageList = [];
                controller.imageLocalPathList = [];
                Get.toNamed(Routes.addLkigaiBoard);
              }),
        )),
      ),
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
                          controller.selectedType,
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
              child: GetBuilder<LkigaiBoardController>(builder: (cont) {
                return cont.dataLoading
                    ? LoadingAnimation()
                    : !cont.dataLoading && cont.lkigaiList.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.35),
                            child: Text(
                              "Empty ${cont.selectedType}",
                              style: TextStyles.text3,
                            ),
                          )
                        : ListView.builder(
                            itemCount: cont.lkigaiList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  cont.selectedLkigai = cont.lkigaiList[index];
                                  Get.toNamed(Routes.lkigaiDetail);
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
                                            cont.lkigaiList[index].title!,
                                            style: TextStyles.text3!.copyWith(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                customSheet(context,
                                                    cont.lkigaiList[index]);
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
                                                text: '12-may-2024',
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

  customSheet(BuildContext context, LkigaiModel lkigai) {
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
                    buttonText:
                        "Edit ${Get.find<LkigaiBoardController>().selectedType}",
                    buttonColor: Color(0xFFD6F6FB),
                    buttonTextColor: Color(0xFF177D8C),
                    onTap: () {
                      Get.find<LkigaiBoardController>().titleCtrl.text =
                          lkigai.title!;
                      Get.find<LkigaiBoardController>().descriptionCtrl.text =
                          lkigai.description!;
                          Get.find<LkigaiBoardController>().selectedLkigai=lkigai;
                      Get.toNamed(Routes.updateLkigai);
                    },
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ElevatedButtonW(
                    buttonText: "Delete Task",
                    buttonColor: Color(0xFFFFD5D5),
                    buttonTextColor: Color(0xFFFF1616),
                    onTap: () {
                      Get.find<LkigaiBoardController>()
                          .deleteLkigai(lkigai.sId!, context);
                      // Get.back();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
}
