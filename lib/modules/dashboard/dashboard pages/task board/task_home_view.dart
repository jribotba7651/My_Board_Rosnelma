// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:my_board/global_controllers/global_controller.dart';
import 'package:my_board/imports.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/task%20board/add_task_view.dart';
import 'package:my_board/modules/dashboard/dashboard%20pages/task%20board/task_board_controller.dart';

import '../../../../data/models/task_model.dart';
import '../../../../widget/task_card.dart';

class TaskBoardHomeView extends GetView<TaskBoardController> {
  const TaskBoardHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold2,
      bottomNavigationBar: CommonBottomNav(currentModule: 'tasks'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => AddNewTaskView());
        },
        backgroundColor: Color(0xFF008B8B),
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Task',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height * 0.12,
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
                  Divider(
                    thickness: 1.1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customTabCard(type: "To do"),
                          customTabCard(type: "In Progress"),
                          customTabCard(type: "Complete"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<TaskBoardController>(builder: (cont) {
                return Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, left: 15.0, top: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${cont.selectedTab}Task",
                            style: TextStyles.text3,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          GetBuilder<TaskBoardController>(builder: (cont) {
                            return CircleAvatar(
                              backgroundColor: AppColors.appColor,
                              radius: Get.width * 0.03,
                              child: Text(
                                cont.tasksList.length.toString(),
                                style: TextStyles.smallText3!
                                    .copyWith(color: Colors.white),
                              ),
                            );
                          })
                        ],
                      ),

                      ///__________________ Tasks list
                      Expanded(child:
                          GetBuilder<TaskBoardController>(builder: (cont) {
                        return cont.dataLoading
                            ? LoadingAnimation()
                            : !cont.dataLoading && cont.tasksList.isEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Empty Tasks",
                                        style: TextStyles.text3,
                                      ),
                                    ],
                                  )
                                : ListView.builder(
                                    itemCount: cont.tasksList.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          // cont.selectedTask =
                                          //     cont.tasksList[index];
                                          // cont.titleCtrl.text =
                                          //     cont.tasksList[index].title!;
                                          // cont.descriptionCtrl.text = cont
                                          //     .tasksList[index].description!;
                                          // cont.startDate = formatDate(cont
                                          //     .tasksList[index].startedOn
                                          //     .toString());
                                          //      cont.endDate = formatDate(cont
                                          //     .tasksList[index].deadline
                                          //     .toString());
                                          // Get.toNamed(Routes.updateTask);
                                        },
                                        child: TaskCardWidget(
                                          type: cont.selectedTab,
                                          task: cont.tasksList[index],
                                          // task: cont.tasksList[index],
                                        ),
                                      );
                                    },
                                  );
                      }))
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  customTabCard({type}) {
    return Expanded(
      child: GetBuilder<TaskBoardController>(builder: (cont) {
        return InkWell(
          onTap: () {
            cont.changeTab(tab: type);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: cont.selectedTab == type
                  ? Border(
                      bottom: BorderSide(width: 2.0, color: AppColors.appColor),
                    )
                  : null,
            ),
            child: Center(
              child: Text(
                type,
                style: cont.selectedTab == type
                    ? TextStyles.smallText!.copyWith(color: AppColors.appColor)
                    : TextStyles.smallText2,
              ),
            ),
          ),
        );
      }),
    );
  }
}
