// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:my_board/data/models/task_model.dart';
import 'package:my_board/global_controllers/global_controller.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/task%20board/task_board_controller.dart';

import '../imports.dart';

class TaskCardWidget extends StatelessWidget {
  TaskCardWidget({super.key, required this.type, required this.task});

  String type;
  TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      // height: Get.height * 0.15,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.title ?? "No Title",
                  style:
                      TextStyles.text3!.copyWith(fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  width: 5.0,
                ),
                InkWell(
                    onTap: () {
                      customSheet(context, task);
                    },
                    child: Icon(Icons.more_vert_outlined))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                task.description ?? "No Title",
                textAlign: TextAlign.justify,
                style: TextStyles.smallText2!
                    .copyWith(fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 22.0, top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //_____________Start date
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Started on: ',
                          style: TextStyles.smallText!
                              .copyWith(color: AppColors.appColor)),
                      TextSpan(
                          text: formatDate(task.createdAt!),
                          style: TextStyles.smallText2!
                              .copyWith(color: Color(0xFFA3A3A3))),
                    ],
                  ),
                ),

                //_____________Deadline date
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Deadline: ',
                          style: TextStyles.smallText!
                              .copyWith(color: AppColors.appColor)),
                      TextSpan(
                          text: formatDate(task.deadline!),
                          style: TextStyles.smallText2!
                              .copyWith(color: Color(0xFFA3A3A3))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.8,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Status",
                  style:
                      TextStyles.text3!.copyWith(fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  width: 15.0,
                ),
                InkWell(
                  onTap: () {
                    changeTaskSheet(context);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
                    decoration: BoxDecoration(
                        color: type == "To do"
                            ? const Color(0xFFFFD1D1)
                            : type == "In Progress"
                                ? const Color(0xFFFFFDD1)
                                : const Color(0xFFD8FFD1),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Center(child: Text(type)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  changeTaskSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return GetBuilder<TaskBoardController>(builder: (cont) {
            return Container(
              height: Get.height * 0.28,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(12.0),
                    topEnd: Radius.circular(12.0),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    child: Divider(
                      color: AppColors.appColor,
                      thickness: 2.5,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.015,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Status",
                            style: TextStyles.text3,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "To do",
                              style: TextStyles.smallText!
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                            Radio(
                                value: "Todo",
                                activeColor: AppColors.appColor,
                                groupValue: cont.selectedRadioButton,
                                onChanged: (value) {
                                  cont.changeRadio(
                                      newValue: value,
                                      id: task.sId,
                                      context: context);
                                })
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Move to In Progress",
                              style: TextStyles.smallText!
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                            Radio(
                                value: "Inprogress",
                                activeColor: AppColors.appColor,
                                groupValue: cont.selectedRadioButton,
                                onChanged: (value) {
                                  cont.changeRadio(
                                      newValue: value,
                                      id: task.sId,
                                      context: context);
                                })
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Move to Complete",
                              style: TextStyles.smallText!
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                            Radio(
                                value: "Complete",
                                activeColor: AppColors.appColor,
                                groupValue: cont.selectedRadioButton,
                                onChanged: (value) {
                                  cont.changeRadio(
                                      newValue: value,
                                      id: task.sId,
                                      context: context);
                                })
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  customSheet(BuildContext context, TaskModel task) {
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD6F6FB),
                      foregroundColor: Color(0xFF177D8C),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Download"),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD6F6FB),
                      foregroundColor: Color(0xFF177D8C),
                    ),
                    onPressed: () {
                      var cont = Get.find<TaskBoardController>();
                      cont.selectedTask = task;
                      cont.titleCtrl.text = task.title!;
                      cont.descriptionCtrl.text = task.description!;
                      cont.startDate = formatDate(cont.selectedTask.startedOn!);
                      cont.endDate = formatDate(cont.selectedTask.deadline!);
                      print(cont.startDate);
                      print(cont.endDate);
                      Get.toNamed(Routes.updateTask);
                    },
                    child: const Text("Edit Task"),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFD5D5),
                      foregroundColor: Color(0xFFFF1616),
                    ),
                    onPressed: () {
                      Get.find<TaskBoardController>()
                          .deleteTask(task.sId!, context);
                    },
                    child: const Text("Delete Task"),
                  )
                ],
              ),
            ),
          );
        });
  }
}
